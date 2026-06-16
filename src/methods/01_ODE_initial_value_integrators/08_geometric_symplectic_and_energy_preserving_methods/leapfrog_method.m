function [tout, yout, stats] = leapfrog_method(bench, opts)
[tout, yout, stats] = velocity_verlet(bench, opts);
end
