function [tout, yout, stats] = backward_euler(bench, opts)
tout=make_uniform_grid(bench.tspan, opts.h); yout=zeros(numel(tout),numel(bench.y0)); yout(1,:)=bench.y0(:).';
stats=basic_stats(numel(tout)-1,0);
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); yn=yout(n,:).'; tn1=tout(n+1);
    G=@(Y) Y-yn-h*bench.rhs(tn1,Y);
    [Y,info]=newton_solve(G, yn, opts);
    yout(n+1,:)=Y.';
    stats.nfev=stats.nfev+info.n_jacobian*2*numel(yn)+info.n_newton+1;
    stats.n_newton=stats.n_newton+info.n_newton; stats.n_jacobian=stats.n_jacobian+info.n_jacobian; stats.n_linear_solve=stats.n_linear_solve+info.n_linear_solve;
    if ~info.success, stats.status=info.status; return; end
end
end
