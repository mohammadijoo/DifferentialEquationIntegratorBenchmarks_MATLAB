function opts = default_options()
%DEFAULT_OPTIONS Default benchmark and solver options.

opts.h = [];
opts.h_min = 1e-10;
opts.h_max = [];
opts.rtol = 1e-6;
opts.atol = 1e-9;
opts.ref_rtol = 1e-11;
opts.ref_atol = 1e-13;
opts.max_steps = 200000;
opts.max_norm = 1e10;
opts.newton_tol = 1e-10;
opts.newton_maxit = 25;
opts.fd_eps = 1e-7;
opts.plot_visible = 'off';
opts.save_figures = true;
opts.plot_dpi = 450;
opts.plot_width_px = 2200;
opts.plot_height_px = 1400;
opts.plot_max_methods = Inf;
opts.plot_label_font_size = 7;
opts.metric_grid_points = 2000;
opts.adaptive_safety = 0.9;
opts.adaptive_min_factor = 0.2;
opts.adaptive_max_factor = 5.0;
opts.verbose = true;
end
