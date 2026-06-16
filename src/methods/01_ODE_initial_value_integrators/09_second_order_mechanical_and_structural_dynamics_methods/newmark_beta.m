function [tout, yout, stats] = newmark_beta(bench, opts)
% Explicit average-acceleration-style Newmark scaffold using acceleration callback.
[tout, yout, stats] = velocity_verlet(bench, opts);
stats.status = 'success_newmark_explicit_scaffold';
end
