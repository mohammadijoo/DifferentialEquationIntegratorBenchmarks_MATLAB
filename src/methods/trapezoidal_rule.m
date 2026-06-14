function [t, Y, stats] = trapezoidal_rule(problem, opts)
%TRAPEZOIDAL_RULE Implicit trapezoidal / Crank-Nicolson method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'TrapezoidalRule');
end

function [yn, info] = step(f, t, y, h, opts)
fn = f(t, y);
yGuess = y + h*fn;
residual = @(z) z - y - 0.5*h*(fn + f(t + h, z));
[yn, ni] = newton_solve(residual, yGuess, opts);
info = ni;
info.nfev = 1 + 2 + 2*numel(y)*info.n_jacobian + info.n_newton;
end
