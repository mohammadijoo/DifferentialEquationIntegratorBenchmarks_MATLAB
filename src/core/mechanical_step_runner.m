function [t, Y, stats] = mechanical_step_runner(problem, opts, stepFun, methodName)
%MECHANICAL_STEP_RUNNER Fixed-step loop for methods that need problem.mechanical.

stats = init_stats(methodName);
t0 = problem.tspan(1);
tf = problem.tspan(2);

if isempty(opts.h)
    h = (tf - t0) / 1000;
else
    h = opts.h;
end

if h <= 0
    error('Step size h must be positive.');
end

maxSteps = opts.max_steps;
t = zeros(maxSteps + 1, 1);
Y = zeros(maxSteps + 1, numel(problem.y0));

t(1) = t0;
Y(1,:) = problem.y0(:).';

n = 1;
while t(n) < tf && n <= maxSteps
    hStep = min(h, tf - t(n));
    y = Y(n,:).';
    [yNext, info] = stepFun(problem, t(n), y, hStep, opts);
    stats = accumulate_stats(stats, info);

    if ~info.success
        stats.success = false;
        stats.status = info.status;
        break;
    end

    if any(~isfinite(yNext)) || norm(yNext, inf) > opts.max_norm
        stats.success = false;
        stats.status = 'blowup';
        break;
    end

    n = n + 1;
    t(n) = t(n-1) + hStep;
    Y(n,:) = yNext(:).';
end

if n > maxSteps
    stats.success = false;
    stats.status = 'max_steps_exceeded';
end
if stats.success
    stats.status = 'success';
end
stats.n_steps = max(0, n-1);
t = t(1:n);
Y = Y(1:n,:);
end
