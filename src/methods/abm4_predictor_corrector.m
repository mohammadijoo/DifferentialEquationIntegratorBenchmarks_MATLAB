function [t, Y, stats] = abm4_predictor_corrector(problem, opts)
%ABM4_PREDICTOR_CORRECTOR Adams-Bashforth-Moulton PECE predictor-corrector.

stats = init_stats('ABM4PredictorCorrector');
f = problem.f; t0 = problem.tspan(1); tf = problem.tspan(2);
h = opts.h; maxSteps = opts.max_steps;
t = zeros(maxSteps+1,1); Y = zeros(maxSteps+1,numel(problem.y0));
t(1)=t0; Y(1,:)=problem.y0(:).';

n = 1;
while n < 4 && t(n) < tf
    hStep = min(h, tf - t(n));
    [yNext, info] = rk4_step(f, t(n), Y(n,:).', hStep, opts);
    stats = accumulate_stats(stats, info);
    n=n+1; t(n)=t(n-1)+hStep; Y(n,:)=yNext(:).';
end

while t(n) < tf && n <= maxSteps
    hStep = min(h, tf - t(n));
    f0 = f(t(n),   Y(n,:).');
    f1 = f(t(n-1), Y(n-1,:).');
    f2 = f(t(n-2), Y(n-2,:).');
    f3 = f(t(n-3), Y(n-3,:).');
    yPred = Y(n,:).' + hStep*(55*f0 - 59*f1 + 37*f2 - 9*f3)/24;
    fPred = f(t(n)+hStep, yPred);
    yNext = Y(n,:).' + hStep*(9*fPred + 19*f0 - 5*f1 + f2)/24;
    stats.nfev = stats.nfev + 5;
    if any(~isfinite(yNext)) || norm(yNext,inf) > opts.max_norm
        stats.success = false; stats.status='blowup'; break;
    end
    n=n+1; t(n)=t(n-1)+hStep; Y(n,:)=yNext(:).';
end
stats.n_steps=max(0,n-1); t=t(1:n); Y=Y(1:n,:);
if stats.success, stats.status='success'; end
end
