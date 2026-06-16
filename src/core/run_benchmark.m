function records = run_benchmark(benchRecord, methods, opts)
%RUN_BENCHMARK Execute all applicable methods on one benchmark.

if ~benchRecord.implemented
    records = skipped_benchmark_record(benchRecord, methods, 'benchmark_planned_not_runnable');
    return;
end

bench = benchRecord.factory();
bench.registry = benchRecord;

outDir = fullfile(opts.results_dir, bench.name);
if opts.write_tables || opts.write_plots
    if ~exist(outDir, 'dir'), mkdir(outDir); end
end

records = empty_record_array();
ref = [];
try
    ref = compute_reference_solution(bench, opts);
catch ME
    warning('Reference solution failed for %s: %s', bench.name, ME.message);
end

for k = 1:numel(methods)
    method = methods(k);
    rec = empty_record();
    rec.benchmark = bench.name;
    rec.method = method.name;
    rec.method_display = method.displayName;
    rec.category = method.category;
    rec.status = 'not_run';
    rec.message = '';

    if ~method.implemented || isempty(method.solver)
        rec.status = 'method_planned_not_implemented';
        records(end+1,1) = rec; %#ok<AGROW>
        continue;
    end
    if ~method_supports_benchmark(method, bench)
        rec.status = 'not_applicable';
        records(end+1,1) = rec; %#ok<AGROW>
        continue;
    end

    try
        if opts.verbose
            fprintf('  [run ] %-32s ', method.displayName);
        end
        tic;
        [tout, yout, stats] = method.solver(bench, opts);
        rec.cpu_time = toc;
        metrics = compute_metrics(bench, tout, yout, ref);
        rec.final_error = metrics.final_error;
        rec.max_error = metrics.max_error;
        rec.rmse_error = metrics.rmse_error;
        rec.max_invariant_error = metrics.max_invariant_error;
        rec.n_steps = stats_get(stats, 'n_steps', max(0,numel(tout)-1));
        rec.nfev = stats_get(stats, 'nfev', NaN);
        rec.n_rejected = stats_get(stats, 'n_rejected', 0);
        rec.n_jacobian = stats_get(stats, 'n_jacobian', 0);
        rec.n_newton = stats_get(stats, 'n_newton', 0);
        rec.n_linear_solve = stats_get(stats, 'n_linear_solve', 0);
        rec.status = stats_get(stats, 'status', 'success');
        if opts.verbose
            fprintf('status=%s, error=%g, cpu=%g s\n', rec.status, rec.final_error, rec.cpu_time);
        end
    catch ME
        rec.cpu_time = NaN;
        rec.status = 'failure';
        rec.message = ME.message;
        if opts.verbose
            fprintf('status=failure: %s\n', ME.message);
        end
    end
    records(end+1,1) = rec; %#ok<AGROW>
end

if opts.write_tables
    write_results_table(records, fullfile(outDir, 'summary.csv'));
end
if opts.write_plots
    try
        plot_benchmark_summary(records, fullfile(outDir, 'summary_plots'));
    catch ME
        warning('Plotting failed for %s: %s', bench.name, ME.message);
    end
end
end
