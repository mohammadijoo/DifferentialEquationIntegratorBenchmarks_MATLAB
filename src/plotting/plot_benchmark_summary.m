function plot_benchmark_summary(records, outPrefix)
%PLOT_BENCHMARK_SUMMARY Simple error and CPU plots.
if isempty(records), return; end
valid = strcmp({records.status}, 'success') | startsWith({records.status}, 'success_');
if ~any(valid), return; end
R = records(valid);
names = {R.method};
err = [R.final_error]; cpu = [R.cpu_time];
folder = fileparts(outPrefix); if ~isempty(folder) && ~exist(folder,'dir'), mkdir(folder); end
figure('Visible','off'); bar(err); set(gca,'YScale','log'); xticks(1:numel(names)); xticklabels(names); xtickangle(45); ylabel('final error'); grid on; saveas(gcf,[outPrefix '_final_error.png']); close(gcf);
figure('Visible','off'); bar(cpu); xticks(1:numel(names)); xticklabels(names); xtickangle(45); ylabel('CPU time (s)'); grid on; saveas(gcf,[outPrefix '_cpu_time.png']); close(gcf);
end
