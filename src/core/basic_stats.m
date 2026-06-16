function stats = basic_stats(n_steps, nfev)
stats = struct();
stats.n_steps = n_steps;
stats.nfev = nfev;
stats.n_rejected = 0;
stats.n_jacobian = 0;
stats.n_newton = 0;
stats.n_linear_solve = 0;
stats.status = 'success';
end
