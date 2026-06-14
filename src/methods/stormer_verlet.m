function [t, Y, stats] = stormer_verlet(problem, opts)
%STORMER_VERLET Position form of Verlet method for q''=a(q).

stats = init_stats('Verlet');
t0 = problem.tspan(1); tf = problem.tspan(2); h = opts.h;
maxSteps = opts.max_steps;
qDim = problem.mechanical.q_dim;

t = zeros(maxSteps+1, 1);
Y = zeros(maxSteps+1, numel(problem.y0));
t(1) = t0;
Y(1,:) = problem.y0(:).';

[q0, v0] = mech_split(problem, problem.y0(:));
a0 = problem.mechanical.accel(t0, q0);
qPrev = q0 - h*v0 + 0.5*h^2*a0;
qCurr = q0;

n = 1;
while t(n) < tf && n <= maxSteps
    hStep = min(h, tf - t(n));
    a = problem.mechanical.accel(t(n), qCurr);
    qNext = 2*qCurr - qPrev + hStep^2*a;
    vApprox = (qNext - qPrev)/(2*hStep);
    yNext = mech_join(qNext, vApprox);
    stats.nfev = stats.nfev + 1;
    if any(~isfinite(yNext)) || norm(yNext,inf) > opts.max_norm
        stats.success=false; stats.status='blowup'; break;
    end
    qPrev = qCurr;
    qCurr = qNext;
    n=n+1; t(n)=t(n-1)+hStep; Y(n,:)=yNext(:).';
end
stats.n_steps=max(0,n-1); t=t(1:n); Y=Y(1:n,:);
if stats.success, stats.status='success'; end
end
