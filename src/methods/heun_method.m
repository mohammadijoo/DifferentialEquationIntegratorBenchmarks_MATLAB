function [t, Y, stats] = heun_method(problem, opts)
%HEUN_METHOD Improved Euler / explicit trapezoidal RK2 method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'Heun');
end

function [yn, info] = step(f, t, y, h, opts) %#ok<INUSD>
k1 = f(t, y);
k2 = f(t + h, y + h*k1);
yn = y + 0.5*h*(k1 + k2);
info.nfev = 2;
end
