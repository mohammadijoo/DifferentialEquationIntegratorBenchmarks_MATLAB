function [t, Y, stats] = ros2_method(problem, opts)
%ROS2_METHOD Two-stage Rosenbrock method for moderately stiff systems.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'ROS2');
end

function [yn, info] = step(f, t, y, h, opts)
gamma = 1 - 1/sqrt(2);
J = finite_diff_jacobian(f, t, y, opts);
M = eye(numel(y)) - gamma*h*J;
f0 = f(t, y);
k1 = M \ (h*f0);
f1 = f(t+h, y+k1);
k2 = M \ (h*f1 - 2*gamma*h*J*k1);
yn = y + 0.5*(k1 + k2);
info.nfev = 2 + 2*numel(y);
info.n_jacobian = 1;
info.n_linear_solve = 2;
end
