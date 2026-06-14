function [t, Y, stats] = adaptive_rk_runner(problem, opts, stepFun, order, methodName)
%ADAPTIVE_RK_RUNNER Generic adaptive embedded RK loop.

stats = init_stats(methodName);
f = problem.f; t0 = problem.tspan(1); tf = problem.tspan(2);

if isempty(opts.h)
    h = (tf - t0)/1000;
else
    h = opts.h;
end
if ~isempty(opts.h_max)
    h = min(h, opts.h_max);
end

maxSteps = opts.max_steps;
t = zeros(maxSteps+1,1); Y = zeros(maxSteps+1,numel(problem.y0));
t(1)=t0; Y(1,:)=problem.y0(:).';

n = 1;
while t(n) < tf && n <= maxSteps
    h = min(h, tf - t(n));
    y = Y(n,:).';
    [yTry, errVec, info] = stepFun(f, t(n), y, h);
    stats.nfev = stats.nfev + info.nfev;

    scale = opts.atol + opts.rtol .* max(abs(y), abs(yTry));
    errNorm = sqrt(mean((errVec ./ scale).^2));

    if errNorm <= 1 || h <= opts.h_min
        n = n + 1;
        t(n) = t(n-1) + h;
        Y(n,:) = yTry(:).';
        if any(~isfinite(yTry)) || norm(yTry,inf) > opts.max_norm
            stats.success=false; stats.status='blowup'; break;
        end
        if errNorm == 0
            fac = opts.adaptive_max_factor;
        else
            fac = opts.adaptive_safety * errNorm^(-1/(order+1));
            fac = min(opts.adaptive_max_factor, max(opts.adaptive_min_factor, fac));
        end
        h = h * fac;
    else
        stats.n_rejected = stats.n_rejected + 1;
        fac = opts.adaptive_safety * errNorm^(-1/(order+1));
        fac = max(opts.adaptive_min_factor, min(1.0, fac));
        h = h * fac;
    end

    if ~isempty(opts.h_max)
        h = min(h, opts.h_max);
    end
    if h < opts.h_min
        stats.success=false; stats.status='step_too_small'; break;
    end
end

if n > maxSteps
    stats.success=false; stats.status='max_steps_exceeded';
end
if stats.success, stats.status='success'; end
stats.n_steps=max(0,n-1);
t=t(1:n); Y=Y(1:n,:);
end
