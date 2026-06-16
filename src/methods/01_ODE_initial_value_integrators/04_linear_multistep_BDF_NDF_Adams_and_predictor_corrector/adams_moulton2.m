function [tout, yout, stats] = adams_moulton2(bench, opts)
[tout,yout,stats]=trapezoidal_rule(bench,opts);
end
