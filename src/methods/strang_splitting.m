function [t, Y, stats] = strang_splitting(problem, opts)
%STRANG_SPLITTING Strang splitting for H(q,p)=T(p)+V(q).
% For separable mechanics, this is equivalent to velocity Verlet.
[t, Y, stats] = velocity_verlet(problem, opts);
stats.method = 'StrangSplitting';
end
