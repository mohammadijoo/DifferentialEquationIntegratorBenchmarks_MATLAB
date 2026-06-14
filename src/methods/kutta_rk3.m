function [t, Y, stats] = kutta_rk3(problem, opts)
%KUTTA_RK3 Classical third-order Kutta Runge-Kutta method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'KuttaRK3');
end

function [yn, info] = step(f, t, y, h, opts) %#ok<INUSD>
k1 = f(t, y);
k2 = f(t + 0.5*h, y + 0.5*h*k1);
k3 = f(t + h, y - h*k1 + 2*h*k2);
yn = y + h*(k1 + 4*k2 + k3)/6;
info.nfev = 3;
end
