function [t, Y, stats] = backward_euler(problem, opts)
%BACKWARD_EULER Fully implicit first-order method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'BackwardEuler');
end

function [yn, info] = step(f, t, y, h, opts)
yGuess = y + h*f(t, y);
residual = @(z) z - y - h*f(t + h, z);
[yn, ni] = newton_solve(residual, yGuess, opts);
info = ni;
info.nfev = 2 + 2*numel(y)*info.n_jacobian + info.n_newton;
end
