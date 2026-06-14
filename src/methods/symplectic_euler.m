function [t, Y, stats] = symplectic_euler(problem, opts)
%SYMPLECTIC_EULER Velocity-first symplectic Euler for separable mechanics.
[t, Y, stats] = mechanical_step_runner(problem, opts, @step, 'SymplecticEuler');
end

function [yn, info] = step(problem, t, y, h, opts) %#ok<INUSD>
[q, v] = mech_split(problem, y);
a = problem.mechanical.accel(t, q);
vn = v + h*a;
qn = q + h*vn;
yn = mech_join(qn, vn);
info.nfev = 1;
info.success = true;
info.status = 'success';
end
