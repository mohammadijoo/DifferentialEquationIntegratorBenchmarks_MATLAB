function [t, Y, stats] = explicit_midpoint(problem, opts)
%EXPLICIT_MIDPOINT Second-order explicit midpoint Runge-Kutta method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'ExplicitMidpoint');
end

function [yn, info] = step(f, t, y, h, opts) %#ok<INUSD>
k1 = f(t, y);
k2 = f(t + 0.5*h, y + 0.5*h*k1);
yn = y + h*k2;
info.nfev = 2;
end
