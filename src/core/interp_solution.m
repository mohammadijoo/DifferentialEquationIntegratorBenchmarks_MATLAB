function Yq = interp_solution(t, Y, tq)
%INTERP_SOLUTION Interpolate matrix solution Y(t) at query times tq.

if numel(t) == 1
    Yq = repmat(Y(1, :), numel(tq), 1);
    return;
end

Yq = interp1(t, Y, tq, 'pchip', 'extrap');
end
