%% Basic smoke test
% Run a small subset to check path and method compatibility.

clear; clc;
addpath(genpath(fullfile(fileparts(mfilename('fullpath')), '..', 'src')));

opts = default_options();
opts.metric_grid_points = 200;
opts.plot_visible = 'off';

problem = benchmark_linear_decay();
problem.tspan = [0 1];
problem.default_h = 0.05;

methods = method_registry();
keep = ismember({methods.name}, {'ForwardEuler','RK4','DormandPrinceRK45','BackwardEuler'});
methods = methods(keep);

run_benchmark(problem, methods, opts);

disp('Smoke test completed.');
