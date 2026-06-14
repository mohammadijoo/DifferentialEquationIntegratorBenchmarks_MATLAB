%% run_all.m
% Run all registered benchmark problems with all applicable integrators.

clear; clc;

addpath(genpath(fullfile(pwd, 'src')));

benchmarks = benchmark_registry();
methods = method_registry();
opts = default_options();

fprintf('Differential Equation Integrator Benchmarks\n');
fprintf('Benchmarks: %d | Methods: %d\n\n', numel(benchmarks), numel(methods));

for i = 1:numel(benchmarks)
    fprintf('\n============================================================\n');
    fprintf('Running benchmark: %s\n', benchmarks(i).name);
    fprintf('============================================================\n');
    run_benchmark(benchmarks(i), methods, opts);
end

fprintf('\nAll benchmark runs completed. See the results/ folder.\n');
