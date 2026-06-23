function plot_benchmark_summary(records, outPrefix)
%PLOT_BENCHMARK_SUMMARY Plot trajectory errors, repeated timing, and work.
if isempty(records), return; end
valid = strcmp({records.status}, 'success') | startsWith({records.status}, 'success_');
if ~any(valid), return; end
R = records(valid);
names = {R.method};
folder = fileparts(outPrefix);
if ~isempty(folder) && ~exist(folder,'dir'), mkdir(folder); end

save_metric_bar([R.final_error], names, 'Final-time error', ...
    [outPrefix '_final_error.png'], true);
save_metric_bar([R.time_average_error], names, 'Time-averaged trajectory error', ...
    [outPrefix '_time_average_error.png'], true);
save_metric_bar([R.rmse_error], names, 'Time-weighted RMS trajectory error', ...
    [outPrefix '_rmse_error.png'], true);
save_metric_bar([R.max_error], names, 'Maximum trajectory error', ...
    [outPrefix '_max_error.png'], true);
save_metric_bar([R.nfev], names, 'Right-hand-side evaluations', ...
    [outPrefix '_nfev.png'], false);

cpu = [R.cpu_time];
cpuStd = [R.cpu_time_std];
if any(isfinite(cpu))
    figure('Visible','off');
    bar(cpu);
    hold on;
    errorbar(1:numel(cpu), cpu, cpuStd, 'k.', 'LineWidth', 1);
    hold off;
    xticks(1:numel(names));
    xticklabels(names);
    xtickangle(45);
    ylabel('Median elapsed time (s)');
    title('Repeated timing; error bars show one standard deviation');
    grid on;
    saveas(gcf,[outPrefix '_cpu_time.png']);
    close(gcf);
end
end

function save_metric_bar(values, names, yLabel, filename, useLogScale)
plotValues = values;
if useLogScale
    plotValues(~isfinite(plotValues) | plotValues <= 0) = NaN;
else
    plotValues(~isfinite(plotValues)) = NaN;
end
if ~any(isfinite(plotValues)), return; end

figure('Visible','off');
bar(plotValues);
if useLogScale, set(gca,'YScale','log'); end
xticks(1:numel(names));
xticklabels(names);
xtickangle(45);
ylabel(yLabel);
grid on;
saveas(gcf,filename);
close(gcf);
end
