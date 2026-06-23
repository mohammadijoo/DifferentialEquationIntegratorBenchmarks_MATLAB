function timed = run_timed_solver(method, bench, opts)
%RUN_TIMED_SOLVER Warm up, repeat timings, and count callback evaluations.
% Timing uses the original benchmark so the counter wrapper does not add
% overhead to the reported elapsed time. Function evaluations are measured
% in one separate, untimed run using a closure rather than a global variable.

repeats = max(1, round(option_value(opts, 'timing_repeats', 3)));
do_warmup = logical(option_value(opts, 'timing_warmup', true));
do_count = logical(option_value(opts, 'count_rhs_evaluations', true));

if do_warmup
    try
        method.solver(bench, opts);
    catch
        % The measured run below reports the actual solver failure.
    end
end

elapsed = zeros(repeats, 1);
tout = [];
yout = [];
stats = struct();
for i = 1:repeats
    timer_id = tic;
    [t_current, y_current, stats_current] = method.solver(bench, opts);
    elapsed(i) = toc(timer_id);
    if i == 1
        tout = t_current;
        yout = y_current;
        stats = stats_current;
    end
end

timed.tout = tout;
timed.yout = yout;
timed.stats = stats;
timed.cpu_time = median(elapsed);
timed.cpu_time_min = min(elapsed);
timed.cpu_time_std = std(elapsed, 0);
timed.timing_repeats = repeats;
timed.nfev = NaN;
timed.nfev_source = 'solver_stats';

if do_count
    [counted_bench, get_count] = instrument_benchmark_calls(bench);
    [~, ~, counted_stats] = method.solver(counted_bench, opts);
    measured_count = get_count();
    if measured_count > 0
        timed.nfev = measured_count;
        timed.nfev_source = 'instrumented_wrapper';
    else
        timed.nfev = stats_get(counted_stats, 'nfev', NaN);
    end
else
    timed.nfev = stats_get(stats, 'nfev', NaN);
end
end

function value = option_value(opts, field_name, default_value)
if isfield(opts, field_name) && ~isempty(opts.(field_name))
    value = opts.(field_name);
else
    value = default_value;
end
end
