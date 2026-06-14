function [t, Y, stats] = implicit_midpoint(problem, opts)
%IMPLICIT_MIDPOINT Second-order implicit midpoint rule.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'ImplicitMidpoint');
end

function [yn, info] = step(f, t, y, h, opts)
yGuess = y + h*f(t, y);
residual = @(z) z - y - h*f(t + 0.5*h, 0.5*(y + z));
[yn, ni] = newton_solve(residual, yGuess, opts);
info = ni;
info.nfev = 2 + 2*numel(y)*info.n_jacobian + info.n_newton;
end
