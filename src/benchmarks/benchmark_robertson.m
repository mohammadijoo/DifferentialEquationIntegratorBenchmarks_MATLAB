function problem = benchmark_robertson()
%BENCHMARK_ROBERTSON Stiff chemical kinetics problem.

y0 = [1; 0; 0];

problem.name = 'RobertsonKinetics';
problem.title = 'Robertson stiff chemical kinetics';
problem.f = @(t, y) [ ...
    -0.04*y(1) + 1e4*y(2)*y(3); ...
     0.04*y(1) - 1e4*y(2)*y(3) - 3e7*y(2)^2; ...
     3e7*y(2)^2];
problem.tspan = [0, 20];
problem.y0 = y0;
problem.default_h = 0.01;
problem.h_max = 0.1;
problem.is_stiff = true;
problem.exact = [];
problem.invariants = struct('name', 'Mass', 'fun', @(t, y) sum(y));
problem.positivity_indices = [1 2 3];
end
