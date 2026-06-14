function [t, Y, stats] = ralston_method(problem, opts)
%RALSTON_METHOD Second-order Ralston method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'Ralston');
end

function [yn, info] = step(f, t, y, h, opts) %#ok<INUSD>
k1 = f(t, y);
k2 = f(t + 2*h/3, y + 2*h*k1/3);
yn = y + h*(0.25*k1 + 0.75*k2);
info.nfev = 2;
end
