function [t, Y, stats] = adams_moulton2(problem, opts)
%ADAMS_MOULTON2 This is the implicit trapezoidal method as a one-step AM method.
[t, Y, stats] = trapezoidal_rule(problem, opts);
stats.method = 'AdamsMoulton2';
end
