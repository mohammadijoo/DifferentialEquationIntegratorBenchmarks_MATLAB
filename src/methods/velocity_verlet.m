function [t, Y, stats] = velocity_verlet(problem, opts)
%VELOCITY_VERLET Velocity Verlet method for q''=a(q).
[t, Y, stats] = mechanical_step_runner(problem, opts, @step, 'VelocityVerlet');
end

function [yn, info] = step(problem, t, y, h, opts) %#ok<INUSD>
[q, v] = mech_split(problem, y);
a0 = problem.mechanical.accel(t, q);
qn = q + h*v + 0.5*h^2*a0;
a1 = problem.mechanical.accel(t+h, qn);
vn = v + 0.5*h*(a0 + a1);
yn = mech_join(qn, vn);
info.nfev = 2;
info.success = true;
info.status = 'success';
end
