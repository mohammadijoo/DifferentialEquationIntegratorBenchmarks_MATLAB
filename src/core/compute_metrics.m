function metrics = compute_metrics(bench, tout, yout, ref)
%COMPUTE_METRICS Error and invariant diagnostics.
metrics.final_error = NaN;
metrics.max_error = NaN;
metrics.rmse_error = NaN;
metrics.max_invariant_error = NaN;
if ~isempty(ref) && isfield(ref, 't') && isfield(ref, 'y') && ~isempty(tout)
    yref = interp1(ref.t, ref.y, tout, 'linear', 'extrap');
    err = vecnorm(yout - yref, 2, 2);
    metrics.final_error = err(end);
    metrics.max_error = max(err);
    metrics.rmse_error = sqrt(mean(err.^2));
end
if isfield(bench, 'invariant') && isa(bench.invariant, 'function_handle')
    vals = zeros(numel(tout),1);
    for i = 1:numel(tout)
        vals(i) = bench.invariant(yout(i,:).');
    end
    metrics.max_invariant_error = max(abs(vals - vals(1)));
end
end
