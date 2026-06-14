function stats = accumulate_stats(stats, info)
%ACCUMULATE_STATS Add local step counters to global stats.

if isempty(info)
    return;
end
fields = {'nfev','n_jacobian','n_newton','n_linear_solve','n_rejected'};
for i = 1:numel(fields)
    fld = fields{i};
    if isfield(info, fld)
        stats.(fld) = stats.(fld) + info.(fld);
    end
end
if isfield(info, 'success') && ~info.success
    stats.success = false;
    if isfield(info, 'status')
        stats.status = info.status;
    else
        stats.status = 'step_failed';
    end
end
end
