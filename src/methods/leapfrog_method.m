function [t, Y, stats] = leapfrog_method(problem, opts)
%LEAPFROG_METHOD Kick-drift-kick leapfrog for separable mechanics.
[t, Y, stats] = mechanical_step_runner(problem, opts, @step, 'Leapfrog');
end

function [yn, info] = step(problem, t, y, h, opts) %#ok<INUSD>
[q, v] = mech_split(problem, y);
a0 = problem.mechanical.accel(t, q);
vHalf = v + 0.5*h*a0;
qn = q + h*vHalf;
a1 = problem.mechanical.accel(t+h, qn);
vn = vHalf + 0.5*h*a1;
yn = mech_join(qn, vn);
info.nfev = 2;
info.success = true;
info.status = 'success';
end
