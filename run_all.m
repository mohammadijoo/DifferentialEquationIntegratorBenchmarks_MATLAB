function allResults = run_all(opts)
%RUN_ALL Run all implemented benchmark/method combinations.
%
% allResults = RUN_ALL()
% allResults = RUN_ALL(opts)
%
% By default, future methods and benchmarks are listed in the
% registries but not executed. This keeps the repository runnable while the
% expanded documentation catalog grows.

if nargin < 1 || isempty(opts)
    opts = default_options();
else
    opts = merge_options(default_options(), opts);
end

repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));

benchmarks = benchmark_registry();
methods = method_registry();

if ~opts.include_planned_benchmarks
    benchmarks = benchmarks([benchmarks.implemented]);
end
if ~opts.include_planned_methods
    methods = methods([methods.implemented]);
end

fprintf('Differential Equation Integrator Benchmarks\n');
fprintf('Benchmarks registered: %d | Methods registered: %d\n', numel(benchmarks), numel(methods));
fprintf('Running only implemented/runnable combinations by default.\n\n');

allResults = struct([]);
for i = 1:numel(benchmarks)
    fprintf('\n============================================================\n');
    fprintf('Running benchmark: %s\n', benchmarks(i).name);
    fprintf('============================================================\n');
    results = run_benchmark(benchmarks(i), methods, opts);
    if isempty(allResults)
        allResults = results;
    else
        allResults = [allResults; results(:)]; %#ok<AGROW>
    end
end

if opts.write_global_summary
    outDir = fullfile(repoRoot, opts.results_dir);
    if ~exist(outDir, 'dir'), mkdir(outDir); end
    write_results_table(allResults, fullfile(outDir, 'all_results_summary.csv'));
end
end
