function opts = default_options()
%DEFAULT_OPTIONS Default options for benchmark execution.

opts.results_dir = 'results';
opts.tol_ref = 1e-11;
opts.rel_tol = 1e-8;
opts.abs_tol = 1e-10;
opts.h = 1e-2;
opts.n_output = 1001;
opts.max_steps = 200000;
opts.newton_tol = 1e-10;
opts.newton_maxit = 20;
opts.fd_eps = sqrt(eps);
opts.reference_solver = 'auto';
opts.include_planned_methods = false;
opts.include_planned_benchmarks = false;
opts.write_tables = true;
opts.write_plots = true;
opts.write_global_summary = true;
opts.verbose = true;
end
