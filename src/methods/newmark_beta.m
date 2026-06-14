function [t, Y, stats] = newmark_beta(problem, opts)
%NEWMARK_BETA Average-acceleration Newmark-beta method.
[t, Y, stats] = mechanical_step_runner(problem, opts, @step, 'NewmarkBeta');
end

function [yn, info] = step(problem, t, y, h, opts)
gamma = 1/2;
beta = 1/4;
[q, v] = mech_split(problem, y);
a0 = problem.mechanical.accel(t, q);
qGuess = q + h*v + 0.5*h^2*a0;
residual = @(qNext) qNext - q - h*v - h^2*((0.5-beta)*a0 + beta*problem.mechanical.accel(t+h, qNext));
[qn, ni] = newton_solve(residual, qGuess, opts);
a1 = problem.mechanical.accel(t+h, qn);
vn = v + h*((1-gamma)*a0 + gamma*a1);
yn = mech_join(qn, vn);
info = ni;
info.nfev = 2 + 2*numel(q)*info.n_jacobian + info.n_newton;
end
