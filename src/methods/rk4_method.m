function [t, Y, stats] = rk4_method(problem, opts)
%RK4_METHOD Classical fourth-order Runge-Kutta method.
[t, Y, stats] = fixed_step_runner(problem, opts, @rk4_step, 'RK4');
end
