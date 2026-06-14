function [t, Y, stats] = rkf45_method(problem, opts)
%RKF45_METHOD Adaptive Runge-Kutta-Fehlberg 4(5) method.
[t, Y, stats] = adaptive_rk_runner(problem, opts, @rkf45_step, 4, 'RKF45');
end

function [y5, err, info] = rkf45_step(f, t, y, h)
k1 = f(t, y);
k2 = f(t + h/4, y + h*(k1/4));
k3 = f(t + 3*h/8, y + h*(3*k1/32 + 9*k2/32));
k4 = f(t + 12*h/13, y + h*(1932*k1/2197 - 7200*k2/2197 + 7296*k3/2197));
k5 = f(t + h, y + h*(439*k1/216 - 8*k2 + 3680*k3/513 - 845*k4/4104));
k6 = f(t + h/2, y + h*(-8*k1/27 + 2*k2 - 3544*k3/2565 + 1859*k4/4104 - 11*k5/40));
y4 = y + h*(25*k1/216 + 1408*k3/2565 + 2197*k4/4104 - k5/5);
y5 = y + h*(16*k1/135 + 6656*k3/12825 + 28561*k4/56430 - 9*k5/50 + 2*k6/55);
err = y5 - y4;
info.nfev = 6;
end
