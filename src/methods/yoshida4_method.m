function [t, Y, stats] = yoshida4_method(problem, opts)
%YOSHIDA4_METHOD Fourth-order symplectic composition of velocity Verlet steps.
[t, Y, stats] = mechanical_step_runner(problem, opts, @step, 'Yoshida4');
end

function [yn, info] = step(problem, t, y, h, opts) %#ok<INUSD>
w1 = 1/(2 - 2^(1/3));
w0 = -2^(1/3)/(2 - 2^(1/3));
y1 = vv_substep(problem, t, y, w1*h);
y2 = vv_substep(problem, t + w1*h, y1, w0*h);
yn = vv_substep(problem, t + (w1+w0)*h, y2, w1*h);
info.nfev = 6;
info.success = true;
info.status = 'success';
end

function yout = vv_substep(problem, t, y, h)
[q, v] = mech_split(problem, y);
a0 = problem.mechanical.accel(t, q);
qn = q + h*v + 0.5*h^2*a0;
a1 = problem.mechanical.accel(t+h, qn);
vn = v + 0.5*h*(a0 + a1);
yout = mech_join(qn, vn);
end
