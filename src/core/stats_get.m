function value = stats_get(stats, field, defaultValue)
if nargin < 3, defaultValue = []; end
if isstruct(stats) && isfield(stats, field)
    value = stats.(field);
else
    value = defaultValue;
end
end
