function problem = benchmark_linear_decay()
%BENCHMARK_LINEAR_DECAY Dahlquist scalar linear test equation.

lambda = -10;
y0 = 1;

problem.name = 'LinearTestEquation';
problem.title = 'Linear decay / Dahlquist test equation';
problem.f = @(t, y) lambda * y;
problem.tspan = [0, 5];
problem.y0 = y0;
problem.default_h = 0.01;
problem.h_max = 0.1;
problem.is_stiff = false;
problem.exact = @(t) y0 * exp(lambda * t);
problem.params.lambda = lambda;
problem.invariants = [];
problem.positivity_indices = 1;
end
