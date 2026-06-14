function rec = empty_metric_record(problem, method, status)
%EMPTY_METRIC_RECORD Create one metrics row with NaN defaults.

rec.problem = problem.name;
rec.method = method.name;
rec.display_name = method.displayName;
rec.category = method.category;
rec.status = status;
rec.final_error = NaN;
rec.max_error = NaN;
rec.rmse_error = NaN;
rec.cpu_time = NaN;
rec.n_steps = NaN;
rec.nfev = NaN;
rec.n_jacobian = NaN;
rec.n_newton = NaN;
rec.n_linear_solve = NaN;
rec.n_rejected = NaN;
rec.max_invariant_error = NaN;
rec.final_invariant_error = NaN;
rec.invariant_names = '';
rec.min_state_value = NaN;
rec.message = '';
end
