function problem = benchmark_lorenz()
%BENCHMARK_LORENZ Chaotic Lorenz 1963 system.

sigma = 10;
rho = 28;
beta = 8/3;
y0 = [1; 1; 1];

problem.name = 'LorenzSystem';
problem.title = 'Lorenz chaotic system';
problem.f = @(t, y) [ ...
    sigma*(y(2)-y(1)); ...
    y(1)*(rho-y(3))-y(2); ...
    y(1)*y(2)-beta*y(3)];
problem.tspan = [0, 30];
problem.metric_tspan = [0, 8]; % long-time pointwise error is not fair for chaos
problem.y0 = y0;
problem.default_h = 0.005;
problem.h_max = 0.05;
problem.is_stiff = false;
problem.exact = [];
problem.params.sigma = sigma;
problem.params.rho = rho;
problem.params.beta = beta;
problem.invariants = [];
problem.positivity_indices = [];
end
