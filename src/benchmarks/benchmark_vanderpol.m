function problem = benchmark_vanderpol()
%BENCHMARK_VANDERPOL Nonlinear oscillator with stiffness transition.

mu = 10;
y0 = [2; 0];

problem.name = 'VanDerPolOscillator';
problem.title = 'Van der Pol oscillator';
problem.f = @(t, y) [y(2); mu*(1 - y(1)^2)*y(2) - y(1)];
problem.tspan = [0, 40];
problem.y0 = y0;
problem.default_h = 0.01;
problem.h_max = 0.1;
problem.is_stiff = true;
problem.exact = [];
problem.params.mu = mu;
problem.invariants = [];
problem.positivity_indices = [];
end
