function [tout, yout, stats] = strang_splitting(bench, opts)
[tout, yout, stats] = velocity_verlet(bench, opts);
end
