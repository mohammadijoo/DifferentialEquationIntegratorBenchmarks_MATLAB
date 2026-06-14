function run_benchmark(problem, methods, baseOpts)
%RUN_BENCHMARK Run all applicable methods on one benchmark problem.

outDir = fullfile(pwd, 'results', problem.name);
if ~exist(outDir, 'dir')
    mkdir(outDir);
end

ref = compute_reference(problem, baseOpts);

records = struct([]);
solutions = struct('method', {}, 't', {}, 'Y', {}, 'stats', {});

for i = 1:numel(methods)
    method = methods(i);
    opts = baseOpts;
    if isfield(problem, 'default_h') && ~isempty(problem.default_h)
        opts.h = problem.default_h;
    end
    if isfield(problem, 'h_max') && ~isempty(problem.h_max)
        opts.h_max = problem.h_max;
    end

    if ~method_applies(problem, method)
        fprintf('  [skip] %-28s not applicable\n', method.name);
        rec = empty_metric_record(problem, method, 'not_applicable');
        records = append_record(records, rec); %#ok<AGROW>
        continue;
    end

    fprintf('  [run ] %-28s ', method.name);
    try
        tic;
        [t, Y, stats] = method.solver(problem, opts);
        elapsed = toc;
        stats.cpu_time = elapsed;
        rec = compute_metrics(problem, method, t, Y, stats, ref);
        fprintf('status=%s, error=%g, cpu=%g s\n', rec.status, rec.final_error, rec.cpu_time);
        solutions(end+1).method = method.name; %#ok<AGROW>
        solutions(end).t = t;
        solutions(end).Y = Y;
        solutions(end).stats = stats;
    catch ME
        elapsed = toc;
        fprintf('failed: %s\n', ME.message);
        rec = empty_metric_record(problem, method, 'failed');
        rec.cpu_time = elapsed;
        rec.message = sanitize_message(ME.message);
    end
    records = append_record(records, rec); %#ok<AGROW>
end

write_results_table(records, fullfile(outDir, 'metrics.csv'));
save(fullfile(outDir, 'benchmark_results.mat'), 'problem', 'methods', 'records', 'solutions', 'ref');
plot_benchmark_results(problem, records, solutions, ref, outDir, baseOpts);
end

function records = append_record(records, rec)
%APPEND_RECORD Append a metrics record while tolerating field-order differences.
% MATLAB struct arrays require identical field names and compatible ordering.
% This helper prevents 'Subscripted assignment between dissimilar structures'.

if isempty(records)
    records = rec;
    return;
end

recordFields = fieldnames(records);
recFields = fieldnames(rec);

% Add any new fields from rec to the existing records.
for k = 1:numel(recFields)
    name = recFields{k};
    if ~isfield(records, name)
        [records.(name)] = deal(default_field_value(rec.(name)));
        recordFields = fieldnames(records);
    end
end

% Add any missing fields from existing records to rec.
for k = 1:numel(recordFields)
    name = recordFields{k};
    if ~isfield(rec, name)
        rec.(name) = default_field_value(records(1).(name));
    end
end

rec = orderfields(rec, records);
records(end+1) = rec;
end

function value = default_field_value(example)
%DEFAULT_FIELD_VALUE Pick a safe placeholder for missing metric fields.
if ischar(example)
    value = '';
elseif isstring(example)
    value = string('');
elseif isnumeric(example) || islogical(example)
    value = NaN;
elseif iscell(example)
    value = {};
elseif isstruct(example)
    value = struct([]);
else
    value = [];
end
end

function s = sanitize_message(s)
s = strrep(s, newline, ' ');
s = strrep(s, ',', ';');
end
