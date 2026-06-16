function [tout, yout, stats] = stormer_verlet(bench, opts)
[tout, yout, stats] = velocity_verlet(bench, opts);
end
