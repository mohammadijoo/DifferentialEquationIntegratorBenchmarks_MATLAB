function opts = merge_options(defaults, userOpts)
%MERGE_OPTIONS Merge a user option struct into defaults.
opts = defaults;
if isempty(userOpts), return; end
fields = fieldnames(userOpts);
for k = 1:numel(fields)
    opts.(fields{k}) = userOpts.(fields{k});
end
end
