function write_results_table(records, filename)
%WRITE_RESULTS_TABLE Write metrics records to CSV.

if isempty(records)
    warning('No records to write.');
    return;
end

T = struct2table(records);
writetable(T, filename);
fprintf('  [save] metrics table: %s\n', filename);
end
