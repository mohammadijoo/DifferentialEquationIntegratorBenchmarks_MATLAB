function [t, Y, stats] = forward_euler(problem, opts)
%FORWARD_EULER Explicit Euler method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'ForwardEuler');
end

function [yn, info] = step(f, t, y, h, opts) %#ok<INUSD>
yn = y + h * f(t, y);
info.nfev = 1;
end
