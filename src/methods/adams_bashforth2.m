function [t, Y, stats] = adams_bashforth2(problem, opts)
%ADAMS_BASHFORTH2 Explicit two-step Adams-Bashforth method.

stats = init_stats('AdamsBashforth2');
f = problem.f; t0 = problem.tspan(1); tf = problem.tspan(2);
h = opts.h; maxSteps = opts.max_steps;
t = zeros(maxSteps+1,1); Y = zeros(maxSteps+1,numel(problem.y0));
t(1)=t0; Y(1,:)=problem.y0(:).';

% Starter: RK4
[y2, info] = rk4_step(f, t0, problem.y0(:), min(h,tf-t0), opts);
stats = accumulate_stats(stats, info);
t(2)=t0+min(h,tf-t0); Y(2,:)=y2(:).';

n = 2;
while t(n) < tf && n <= maxSteps
    hStep = min(h, tf - t(n));
    fn = f(t(n), Y(n,:).');
    fnm1 = f(t(n-1), Y(n-1,:).');
    yNext = Y(n,:).' + hStep*(1.5*fn - 0.5*fnm1);
    stats.nfev = stats.nfev + 2;
    if any(~isfinite(yNext)) || norm(yNext,inf) > opts.max_norm
        stats.success = false; stats.status = 'blowup'; break;
    end
    n=n+1; t(n)=t(n-1)+hStep; Y(n,:)=yNext(:).';
end
stats.n_steps = max(0,n-1);
t=t(1:n); Y=Y(1:n,:);
if stats.success, stats.status='success'; end
end
