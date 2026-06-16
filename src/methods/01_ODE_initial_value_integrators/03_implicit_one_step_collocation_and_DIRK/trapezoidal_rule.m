function [tout, yout, stats] = trapezoidal_rule(bench, opts)
tout=make_uniform_grid(bench.tspan, opts.h); yout=zeros(numel(tout),numel(bench.y0)); yout(1,:)=bench.y0(:).';
stats=basic_stats(numel(tout)-1,0);
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); yn=yout(n,:).'; tn=tout(n); tn1=tout(n+1); fn=bench.rhs(tn,yn); stats.nfev=stats.nfev+1;
    G=@(Y) Y-yn-h*(fn+bench.rhs(tn1,Y))/2;
    [Y,info]=newton_solve(G, yn+h*fn, opts); yout(n+1,:)=Y.';
    stats.n_newton=stats.n_newton+info.n_newton; stats.n_jacobian=stats.n_jacobian+info.n_jacobian; stats.n_linear_solve=stats.n_linear_solve+info.n_linear_solve;
    if ~info.success, stats.status=info.status; return; end
end
end
