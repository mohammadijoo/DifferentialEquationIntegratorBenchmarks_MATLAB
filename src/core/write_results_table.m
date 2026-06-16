function write_results_table(records, filename)
%WRITE_RESULTS_TABLE Write record struct array to CSV.
if isempty(records), return; end
folder = fileparts(filename);
if ~isempty(folder) && ~exist(folder, 'dir'), mkdir(folder); end
T = struct2table(records);
writetable(T, filename);
end
