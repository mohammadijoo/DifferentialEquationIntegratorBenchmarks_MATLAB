function test_smoke()
%TEST_SMOKE Minimal smoke test for updated registry and one benchmark.
addpath(genpath(fileparts(fileparts(mfilename('fullpath')))));
opts = default_options(); opts.write_tables=false; opts.write_plots=false; opts.n_output=101; opts.h=0.05; opts.verbose=false;
methods = method_registry(); benchmarks = benchmark_registry();
assert(numel(methods) >= 27);
assert(numel(benchmarks) >= 6);
res = run_one_benchmark('LinearTestEquation', opts);
assert(~isempty(res));
disp('Smoke test passed.');
end
