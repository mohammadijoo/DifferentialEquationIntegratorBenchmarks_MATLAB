function results = run_one_benchmark(benchmarkName, opts)
%RUN_ONE_BENCHMARK Run one benchmark by registry name.

if nargin < 2 || isempty(opts)
    opts = default_options();
else
    opts = merge_options(default_options(), opts);
end

repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));

benchmarks = benchmark_registry();
idx = find(strcmpi({benchmarks.name}, benchmarkName), 1);
if isempty(idx)
    error('Unknown benchmark "%s". Check benchmark_registry.m.', benchmarkName);
end

methods = method_registry();
if ~opts.include_planned_methods
    methods = methods([methods.implemented]);
end

results = run_benchmark(benchmarks(idx), methods, opts);
end
