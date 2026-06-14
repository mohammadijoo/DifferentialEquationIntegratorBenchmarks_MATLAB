function stats = init_stats(methodName)
%INIT_STATS Create a standard statistics structure.

stats.method = methodName;
stats.success = true;
stats.status = 'success';
stats.n_steps = 0;
stats.nfev = 0;
stats.n_jacobian = 0;
stats.n_newton = 0;
stats.n_linear_solve = 0;
stats.n_rejected = 0;
stats.cpu_time = NaN;
stats.message = '';
end
