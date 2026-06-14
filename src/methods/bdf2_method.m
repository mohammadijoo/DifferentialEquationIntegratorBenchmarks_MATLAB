function [t, Y, stats] = bdf2_method(problem, opts)
%BDF2_METHOD Two-step backward differentiation formula.

stats = init_stats('BDF2');
f = problem.f; t0 = problem.tspan(1); tf = problem.tspan(2);
h = opts.h; maxSteps = opts.max_steps;
t = zeros(maxSteps+1,1); Y = zeros(maxSteps+1,numel(problem.y0));
t(1)=t0; Y(1,:)=problem.y0(:).';

% Starter: backward Euler for one step.
hStep = min(h, tf-t0);
[y2, info] = be_step(f, t0, problem.y0(:), hStep, opts);
stats = accumulate_stats(stats, info);
t(2)=t0+hStep; Y(2,:)=y2(:).';

n = 2;
while t(n) < tf && n <= maxSteps
    hStep = min(h, tf - t(n));
    yn = Y(n,:).';
    ynm1 = Y(n-1,:).';
    yGuess = yn + hStep*f(t(n), yn);
    residual = @(z) z - (4/3)*yn + (1/3)*ynm1 - (2/3)*hStep*f(t(n)+hStep, z);
    [yNext, ni] = newton_solve(residual, yGuess, opts);
    info = ni;
    info.nfev = 2 + 2*numel(yn)*info.n_jacobian + info.n_newton;
    stats = accumulate_stats(stats, info);
    if ~info.success
        stats.success=false; stats.status=info.status; break;
    end
    if any(~isfinite(yNext)) || norm(yNext,inf) > opts.max_norm
        stats.success=false; stats.status='blowup'; break;
    end
    n=n+1; t(n)=t(n-1)+hStep; Y(n,:)=yNext(:).';
end
stats.n_steps=max(0,n-1); t=t(1:n); Y=Y(1:n,:);
if stats.success, stats.status='success'; end
end

function [yn, info] = be_step(f, t, y, h, opts)
yGuess = y + h*f(t,y);
residual = @(z) z - y - h*f(t+h,z);
[yn, info] = newton_solve(residual, yGuess, opts);
info.nfev = 2 + 2*numel(y)*info.n_jacobian + info.n_newton;
end
