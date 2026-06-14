function plot_benchmark_results(problem, records, solutions, ref, outDir, opts)
%PLOT_BENCHMARK_RESULTS Generate publication-style benchmark plots.
%
% This version improves readability for dense method comparisons by using:
%   * larger figure canvases,
%   * high-DPI PNG export,
%   * a wider color/style/marker cycle,
%   * smaller work-precision labels,
%   * leader lines from labels to their corresponding data points.

if isempty(solutions)
    return;
end

plot_solution_trajectories(problem, solutions, ref, outDir, opts);
plot_error_vs_time(problem, solutions, ref, outDir, opts);
plot_metric_bars(records, outDir, opts);
plot_work_precision(records, outDir, opts);
plot_invariant_errors(problem, solutions, outDir, opts);
plot_phase_portrait(problem, solutions, ref, outDir, opts);
end

function plot_solution_trajectories(problem, solutions, ref, outDir, opts)
fig = make_benchmark_figure(opts);
hold on; grid on; box on;

maxMethods = min(numel(solutions), get_opt(opts, 'plot_max_methods', numel(solutions)));
for i = 1:maxMethods
    styled_plot(solutions(i).t, solutions(i).Y(:,1), i, maxMethods, solutions(i).method, 'linear');
end
plot(ref.t, ref.Y(:,1), 'k--', 'LineWidth', 2.4, 'DisplayName', ['Reference: ' ref.method]);

xlabel('Time');
ylabel('First state component');
title([problem.title ' - solution comparison']);
style_axes();
style_legend();
save_high_resolution(fig, fullfile(outDir, 'solution_comparison.png'), opts);
close(fig);
end

function plot_error_vs_time(problem, solutions, ref, outDir, opts)
fig = make_benchmark_figure(opts);
hold on; grid on; box on;

maxMethods = min(numel(solutions), get_opt(opts, 'plot_max_methods', numel(solutions)));
for i = 1:maxMethods
    tq = solutions(i).t;
    Yrefq = interp_solution(ref.t, ref.Y, tq);
    err = vecnorm(solutions(i).Y - Yrefq, 2, 2);
    styled_plot(tq, err + eps, i, maxMethods, solutions(i).method, 'semilogy');
end

xlabel('Time');
ylabel('Error norm');
title([problem.title ' - error vs time']);
style_axes();
style_legend();
save_high_resolution(fig, fullfile(outDir, 'error_vs_time.png'), opts);
close(fig);
end

function plot_metric_bars(records, outDir, opts)
T = struct2table(records);
T = T(strcmp(T.status, 'success'), :);
if isempty(T), return; end

metrics = {'final_error','cpu_time','nfev','max_invariant_error'};
for k = 1:numel(metrics)
    m = metrics{k};
    if ~ismember(m, T.Properties.VariableNames), continue; end
    vals = T.(m);
    if all(isnan(vals)), continue; end

    fig = make_benchmark_figure(opts);
    valsForPlot = vals;
    valsForPlot(~isfinite(valsForPlot) | valsForPlot <= 0) = eps;
    b = bar(valsForPlot, 'FaceColor', 'flat');
    colors = method_palette(height(T));
    try
        b.CData = colors;
    catch
        % Older MATLAB releases may not support per-bar CData exactly this way.
    end
    set(gca, 'XTick', 1:height(T), 'XTickLabel', T.method, 'XTickLabelRotation', 55);
    set(gca, 'YScale', 'log');
    grid on; box on;
    ylabel(strrep(m, '_', ' '));
    title(['Metric: ' strrep(m, '_', ' ')]);
    style_axes();
    set(gca, 'FontSize', 9);
    save_high_resolution(fig, fullfile(outDir, [m '_bar.png']), opts);
    close(fig);
end
end

function plot_work_precision(records, outDir, opts)
T = struct2table(records);
T = T(strcmp(T.status, 'success') & isfinite(T.final_error) & isfinite(T.cpu_time), :);
if isempty(T), return; end

fig = make_benchmark_figure(opts);
hold on; grid on; box on;

x = T.cpu_time + eps;
y = T.final_error + eps;
y(~isfinite(y) | y <= 0) = eps;
x(~isfinite(x) | x <= 0) = eps;

colors = method_palette(height(T));
for i = 1:height(T)
    loglog(x(i), y(i), 'o', ...
        'MarkerSize', 8, ...
        'MarkerFaceColor', colors(i,:), ...
        'MarkerEdgeColor', [0.12 0.12 0.12], ...
        'LineWidth', 0.8, ...
        'DisplayName', T.method{i});
end

set(gca, 'XScale', 'log', 'YScale', 'log');
xlabel('CPU time [s]');
ylabel('Final error');
title('Work-precision diagram');
style_axes();

[xText, yText] = compute_label_positions(x, y, T.method);
expand_log_limits([x; xText(:)], [y; yText(:)]);

for i = 1:height(T)
    plot([x(i), xText(i)], [y(i), yText(i)], '-', ...
        'Color', [0.35 0.35 0.35], ...
        'LineWidth', 0.65, ...
        'HandleVisibility', 'off');

    if xText(i) >= x(i)
        hAlign = 'left';
    else
        hAlign = 'right';
    end

    text(xText(i), yText(i), T.method{i}, ...
        'Interpreter', 'none', ...
        'FontSize', get_opt(opts, 'plot_label_font_size', 7), ...
        'HorizontalAlignment', hAlign, ...
        'VerticalAlignment', 'middle', ...
        'BackgroundColor', 'white', ...
        'Margin', 1.0, ...
        'Clipping', 'off');
end

save_high_resolution(fig, fullfile(outDir, 'work_precision.png'), opts);
close(fig);
end

function plot_invariant_errors(problem, solutions, outDir, opts)
if ~isfield(problem, 'invariants') || isempty(problem.invariants)
    return;
end

for k = 1:numel(problem.invariants)
    fig = make_benchmark_figure(opts);
    hold on; grid on; box on;

    invFun = problem.invariants(k).fun;
    maxMethods = min(numel(solutions), get_opt(opts, 'plot_max_methods', numel(solutions)));
    for i = 1:maxMethods
        vals = zeros(numel(solutions(i).t), 1);
        for j = 1:numel(vals)
            vals(j) = invFun(solutions(i).t(j), solutions(i).Y(j,:).');
        end
        styled_plot(solutions(i).t, abs(vals - vals(1)) + eps, i, maxMethods, solutions(i).method, 'semilogy');
    end

    xlabel('Time');
    ylabel(['|\Delta ' problem.invariants(k).name '|']);
    title([problem.title ' - invariant drift: ' problem.invariants(k).name]);
    style_axes();
    style_legend();
    save_high_resolution(fig, fullfile(outDir, ['invariant_' sanitize_filename(problem.invariants(k).name) '.png']), opts);
    close(fig);
end
end

function plot_phase_portrait(problem, solutions, ref, outDir, opts)
if size(ref.Y, 2) < 2
    return;
end
if ~(strcmp(problem.name, 'HarmonicOscillator') || strcmp(problem.name, 'VanDerPolOscillator') || strcmp(problem.name, 'KeplerTwoBody'))
    return;
end

fig = make_benchmark_figure(opts);
hold on; grid on; box on;

maxMethods = min(numel(solutions), get_opt(opts, 'plot_max_methods', numel(solutions)));
if strcmp(problem.name, 'KeplerTwoBody')
    for i = 1:maxMethods
        styled_plot(solutions(i).Y(:,1), solutions(i).Y(:,2), i, maxMethods, solutions(i).method, 'linear');
    end
    plot(ref.Y(:,1), ref.Y(:,2), 'k--', 'LineWidth', 2.4, 'DisplayName', 'Reference');
    xlabel('x');
    ylabel('y');
    axis equal;
else
    for i = 1:maxMethods
        styled_plot(solutions(i).Y(:,1), solutions(i).Y(:,2), i, maxMethods, solutions(i).method, 'linear');
    end
    plot(ref.Y(:,1), ref.Y(:,2), 'k--', 'LineWidth', 2.4, 'DisplayName', 'Reference');
    xlabel('q or x');
    ylabel('v or y');
end

title([problem.title ' - phase portrait']);
style_axes();
style_legend();
save_high_resolution(fig, fullfile(outDir, 'phase_portrait.png'), opts);
close(fig);
end

function fig = make_benchmark_figure(opts)
widthPx = get_opt(opts, 'plot_width_px', 2200);
heightPx = get_opt(opts, 'plot_height_px', 1400);
fig = figure('Visible', opts.plot_visible, ...
    'Color', 'w', ...
    'Units', 'pixels', ...
    'Position', [100 100 widthPx heightPx], ...
    'PaperPositionMode', 'auto');
end

function styled_plot(x, y, idx, n, displayName, mode)
colors = method_palette(n);
lineStyles = {'-', '--', ':', '-.'};
markers = {'none', 'o', 's', '^', 'v', 'd', '>', '<', 'p', 'h', '+', 'x'};
lineStyle = lineStyles{mod(idx-1, numel(lineStyles)) + 1};
marker = markers{mod(idx-1, numel(markers)) + 1};

if strcmp(mode, 'semilogy')
    h = semilogy(x, y, ...
        'Color', colors(idx,:), ...
        'LineStyle', lineStyle, ...
        'LineWidth', 1.8, ...
        'Marker', marker, ...
        'MarkerSize', 4.5, ...
        'DisplayName', displayName);
else
    h = plot(x, y, ...
        'Color', colors(idx,:), ...
        'LineStyle', lineStyle, ...
        'LineWidth', 1.8, ...
        'Marker', marker, ...
        'MarkerSize', 4.5, ...
        'DisplayName', displayName);
end

% Place markers sparsely so dense trajectories remain readable.
if ~strcmp(marker, 'none') && numel(x) > 25
    markerStride = max(1, floor(numel(x) / 18));
    try
        h.MarkerIndices = 1:markerStride:numel(x);
    catch
        % MarkerIndices is unavailable in very old MATLAB releases.
    end
end
end

function colors = method_palette(n)
base = [
    0.000 0.447 0.741
    0.850 0.325 0.098
    0.929 0.694 0.125
    0.494 0.184 0.556
    0.466 0.674 0.188
    0.301 0.745 0.933
    0.635 0.078 0.184
    0.000 0.000 0.000
    0.750 0.000 0.750
    0.000 0.500 0.000
    0.800 0.400 0.000
    0.250 0.250 0.250
    0.600 0.600 0.000
    0.000 0.600 0.600
    0.600 0.000 0.200
    0.200 0.200 0.800
    0.900 0.100 0.500
    0.100 0.700 0.300
    0.500 0.300 0.100
    0.200 0.600 0.900
    0.900 0.500 0.600
    0.150 0.450 0.250
    0.450 0.150 0.650
    0.650 0.450 0.150
    0.100 0.250 0.650
    0.650 0.100 0.450
    0.350 0.650 0.100
];

if n <= size(base, 1)
    colors = base(1:n, :);
else
    extraCount = n - size(base, 1);
    extra = hsv(extraCount + 3);
    extra = extra(1:extraCount, :);
    colors = [base; extra];
end
end

function style_axes()
set(gca, ...
    'FontSize', 11, ...
    'LineWidth', 1.0, ...
    'GridAlpha', 0.25, ...
    'MinorGridAlpha', 0.12);
try
    grid minor;
catch
end
end

function style_legend()
leg = legend('Interpreter', 'none', 'Location', 'eastoutside');
set(leg, 'FontSize', 8, 'Box', 'on');
try
    leg.NumColumns = 2;
catch
end
end

function save_high_resolution(fig, filename, opts)
dpi = get_opt(opts, 'plot_dpi', 450);
try
    exportgraphics(fig, filename, 'Resolution', dpi);
catch
    try
        print(fig, filename, '-dpng', ['-r' num2str(dpi)]);
    catch
        saveas(fig, filename);
    end
end
end

function value = get_opt(opts, fieldName, defaultValue)
if isstruct(opts) && isfield(opts, fieldName) && ~isempty(opts.(fieldName))
    value = opts.(fieldName);
else
    value = defaultValue;
end
end

function [xText, yText] = compute_label_positions(x, y, labels)
% Compute label positions in log-space and distribute them around points.
logX = log10(x(:));
logY = log10(y(:));
rangeX = max(logX) - min(logX);
rangeY = max(logY) - min(logY);
if rangeX <= 0 || ~isfinite(rangeX), rangeX = 1; end
if rangeY <= 0 || ~isfinite(rangeY), rangeY = 1; end

candidateOffsets = [
     0.075  0.065
    -0.085  0.065
     0.075 -0.065
    -0.085 -0.065
     0.115  0.000
    -0.125  0.000
     0.000  0.105
     0.000 -0.105
     0.140  0.105
    -0.150  0.105
     0.140 -0.105
    -0.150 -0.105
     0.185  0.150
    -0.195  0.150
     0.185 -0.150
    -0.195 -0.150
];

n = numel(x);
labelBoxes = zeros(0, 4); % [xmin xmax ymin ymax] in log coordinates
xTextLog = zeros(n,1);
yTextLog = zeros(n,1);

% Label more important/accurate points first: lower error, then lower time.
[~, order] = sortrows([logY, logX], [1 2]);

for kk = 1:n
    i = order(kk);
    bestScore = inf;
    bestPos = [logX(i), logY(i)];
    labelLen = max(6, numel(labels{i}));
    boxW = (0.015 * labelLen + 0.025) * rangeX;
    boxH = 0.040 * rangeY;

    for c = 1:size(candidateOffsets, 1)
        candX = logX(i) + candidateOffsets(c,1) * rangeX;
        candY = logY(i) + candidateOffsets(c,2) * rangeY;
        candBox = [candX - boxW/2, candX + boxW/2, candY - boxH/2, candY + boxH/2];

        overlapPenalty = 0;
        for b = 1:size(labelBoxes, 1)
            overlapX = max(0, min(candBox(2), labelBoxes(b,2)) - max(candBox(1), labelBoxes(b,1)));
            overlapY = max(0, min(candBox(4), labelBoxes(b,4)) - max(candBox(3), labelBoxes(b,3)));
            overlapPenalty = overlapPenalty + overlapX * overlapY;
        end

        distancePenalty = 0.015 * (candidateOffsets(c,1)^2 + candidateOffsets(c,2)^2);
        score = overlapPenalty + distancePenalty;
        if score < bestScore
            bestScore = score;
            bestPos = [candX, candY];
            bestBox = candBox; %#ok<NASGU>
        end
    end

    xTextLog(i) = bestPos(1);
    yTextLog(i) = bestPos(2);
    labelBoxes(end+1,:) = [bestPos(1) - boxW/2, bestPos(1) + boxW/2, bestPos(2) - boxH/2, bestPos(2) + boxH/2]; %#ok<AGROW>
end

xText = 10.^xTextLog;
yText = 10.^yTextLog;
end

function expand_log_limits(xVals, yVals)
xVals = xVals(isfinite(xVals) & xVals > 0);
yVals = yVals(isfinite(yVals) & yVals > 0);
if isempty(xVals) || isempty(yVals), return; end

lx = log10(xVals);
ly = log10(yVals);
padX = 0.12 * max(1e-12, max(lx) - min(lx));
padY = 0.16 * max(1e-12, max(ly) - min(ly));
xlim(10.^[min(lx)-padX, max(lx)+padX]);
ylim(10.^[min(ly)-padY, max(ly)+padY]);
end

function name = sanitize_filename(name)
name = regexprep(name, '[^a-zA-Z0-9_\-]', '_');
end
