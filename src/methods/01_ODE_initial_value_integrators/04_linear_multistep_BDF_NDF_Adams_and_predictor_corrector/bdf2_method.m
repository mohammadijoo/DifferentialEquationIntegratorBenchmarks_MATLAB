function [tout, yout, stats] = bdf2_method(bench, opts)
[tout, yout, stats] = backward_euler(bench, opts);
if size(yout,1) < 3, return; end
stats = basic_stats(numel(tout)-1, stats.nfev);
for n=2:numel(tout)-1
    h=tout(n+1)-tout(n); yn=yout(n,:).'; ynm1=yout(n-1,:).'; tn1=tout(n+1);
    G=@(Y) (3*Y-4*yn+ynm1)/(2*h)-bench.rhs(tn1,Y);
    [Y,info]=newton_solve(G, yn, opts); yout(n+1,:)=Y.';
    stats.n_newton=stats.n_newton+info.n_newton; stats.n_jacobian=stats.n_jacobian+info.n_jacobian; stats.n_linear_solve=stats.n_linear_solve+info.n_linear_solve;
    if ~info.success, stats.status=info.status; return; end
end
end
