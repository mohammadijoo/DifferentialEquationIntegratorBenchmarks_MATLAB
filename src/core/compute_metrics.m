function metrics = compute_metrics(bench, tout, yout, ref)
%COMPUTE_METRICS Error and invariant diagnostics.
metrics.final_error = NaN;
metrics.max_error = NaN;
metrics.time_average_error = NaN;
metrics.rmse_error = NaN;
metrics.max_invariant_error = NaN;
if ~isempty(ref) && isfield(ref, 't') && isfield(ref, 'y') && ~isempty(tout)
    t = tout(:);
    yref = interp1(ref.t, ref.y, t, 'linear', 'extrap');
    err = vecnorm(yout - yref, 2, 2);
    metrics.final_error = err(end);
    metrics.max_error = max(err);

    if numel(t) > 1 && t(end) > t(1)
        duration = t(end) - t(1);
        metrics.time_average_error = trapz(t, err) / duration;
        metrics.rmse_error = sqrt(trapz(t, err.^2) / duration);
    else
        metrics.time_average_error = err(end);
        metrics.rmse_error = err(end);
    end
end
if isfield(bench, 'invariant') && isa(bench.invariant, 'function_handle')
    vals = zeros(numel(tout),1);
    for i = 1:numel(tout)
        vals(i) = bench.invariant(yout(i,:).');
    end
    metrics.max_invariant_error = max(abs(vals - vals(1)));
end
end
