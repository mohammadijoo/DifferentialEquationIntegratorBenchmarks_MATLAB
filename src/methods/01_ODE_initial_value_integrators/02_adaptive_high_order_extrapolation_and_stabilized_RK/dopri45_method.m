function [tout, yout, stats] = dopri45_method(bench, opts)
% Adaptive RK wrapper using MATLAB ode45 as a robust embedded-RK engine.
odeOpts = odeset('RelTol', opts.rel_tol, 'AbsTol', opts.abs_tol);
solT = linspace(bench.tspan(1), bench.tspan(2), opts.n_output).';
[t,y] = ode45(@(t,y) bench.rhs(t,y), solT, bench.y0(:), odeOpts);
tout = t; yout = y;
stats = basic_stats(max(0,numel(t)-1), NaN);
stats.status = 'success';
end
