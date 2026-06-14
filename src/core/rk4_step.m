function [yn, info] = rk4_step(f, t, y, h, opts) %#ok<INUSD>
%RK4_STEP One classical RK4 step.

k1 = f(t, y);
k2 = f(t + 0.5*h, y + 0.5*h*k1);
k3 = f(t + 0.5*h, y + 0.5*h*k2);
k4 = f(t + h, y + h*k3);
yn = y + h*(k1 + 2*k2 + 2*k3 + k4)/6;
info.nfev = 4;
end
