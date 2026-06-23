function test_feedback_improvements()
%TEST_FEEDBACK_IMPROVEMENTS Test PDE, trajectory metrics, and timing changes.
addpath(genpath(fileparts(fileparts(mfilename('fullpath')))));

opts = default_options();
assert(opts.timing_repeats >= 2);
assert(opts.timing_warmup);
assert(opts.count_rhs_evaluations);

benchmarks = benchmark_registry();
swift_index = find(strcmp({benchmarks.name}, 'SwiftHohenbergEquation'), 1);
assert(~isempty(swift_index));
swift = benchmarks(swift_index).factory();
assert(swift.stiff);
assert(strcmp(swift.equationClass, 'pde_mol'));
assert(numel(swift.y0) == 128);
assert(all(isfinite(swift.rhs(0, swift.y0))));

linear_index = find(strcmp({benchmarks.name}, 'LinearTestEquation'), 1);
methods = method_registry();
euler_index = find(strcmp({methods.name}, 'ForwardEuler'), 1);
assert(~isempty(linear_index) && ~isempty(euler_index));

opts.write_tables = false;
opts.write_plots = false;
opts.verbose = false;
opts.h = 0.1;
opts.n_output = 101;
opts.timing_repeats = 2;
opts.timing_warmup = false;
records = run_benchmark(benchmarks(linear_index), methods(euler_index), opts);

assert(numel(records) == 1);
assert(isfinite(records.time_average_error));
assert(isfinite(records.rmse_error));
assert(isfinite(records.max_error));
assert(records.time_average_error > records.final_error);
assert(records.rmse_error > records.final_error);
assert(records.nfev > 0);
assert(strcmp(records.nfev_source, 'instrumented_wrapper'));
assert(records.timing_repeats == 2);
assert(isfinite(records.cpu_time));
assert(isfinite(records.cpu_time_min));
assert(isfinite(records.cpu_time_std));

disp('Feedback improvement tests passed.');
end
