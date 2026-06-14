function rec = compute_metrics(problem, method, t, Y, stats, ref)
%COMPUTE_METRICS Build one performance record for a method/problem pair.

rec = empty_metric_record(problem, method, stats.status);
rec.cpu_time = stats.cpu_time;
rec.n_steps = stats.n_steps;
rec.nfev = stats.nfev;
rec.n_jacobian = stats.n_jacobian;
rec.n_newton = stats.n_newton;
rec.n_linear_solve = stats.n_linear_solve;
rec.n_rejected = stats.n_rejected;
rec.message = stats.message;

if ~stats.success || numel(t) < 2
    return;
end

% Use a shorter metric window for chaotic systems if requested.
tMetric = ref.t;
YRef = ref.Y;
if isfield(problem, 'metric_tspan') && ~isempty(problem.metric_tspan)
    mask = ref.t >= problem.metric_tspan(1) & ref.t <= problem.metric_tspan(2);
    tMetric = ref.t(mask);
    YRef = ref.Y(mask, :);
end

YNum = interp_solution(t, Y, tMetric);
err = vecnorm(YNum - YRef, 2, 2);
rec.final_error = err(end);
rec.max_error = max(err);
rec.rmse_error = sqrt(mean(err.^2));

if isfield(problem, 'invariants') && ~isempty(problem.invariants)
    maxInv = 0;
    finalInv = 0;
    invNames = strings(1, numel(problem.invariants));
    for k = 1:numel(problem.invariants)
        invFun = problem.invariants(k).fun;
        vals = zeros(numel(t), 1);
        for i = 1:numel(t)
            vals(i) = invFun(t(i), Y(i, :).');
        end
        drift = abs(vals - vals(1));
        maxInv = max(maxInv, max(drift));
        finalInv = max(finalInv, drift(end));
        invNames(k) = string(problem.invariants(k).name);
    end
    rec.max_invariant_error = maxInv;
    rec.final_invariant_error = finalInv;
    rec.invariant_names = strjoin(invNames, '|');
end

if isfield(problem, 'positivity_indices') && ~isempty(problem.positivity_indices)
    rec.min_state_value = min(min(Y(:, problem.positivity_indices)));
end
end
