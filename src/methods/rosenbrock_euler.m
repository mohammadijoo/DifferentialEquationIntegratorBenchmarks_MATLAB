function [t, Y, stats] = rosenbrock_euler(problem, opts)
%ROSENBROCK_EULER Linearly implicit Euler method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'RosenbrockEuler');
end

function [yn, info] = step(f, t, y, h, opts)
J = finite_diff_jacobian(f, t, y, opts);
A = eye(numel(y)) - h*J;
rhs = f(t, y);
k = A \ rhs;
yn = y + h*k;
info.nfev = 1 + 2*numel(y);
info.n_jacobian = 1;
info.n_linear_solve = 1;
end
