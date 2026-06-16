function [tout, yout, stats] = rosenbrock_euler(bench, opts)
tout=make_uniform_grid(bench.tspan,opts.h); yout=zeros(numel(tout),numel(bench.y0)); yout(1,:)=bench.y0(:).'; stats=basic_stats(numel(tout)-1,0);
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); t=tout(n); y=yout(n,:).';
    f=bench.rhs(t,y); J=finite_difference_jacobian(@(Y) bench.rhs(t,Y), y, opts);
    k=(eye(numel(y))-h*J)\f;
    yout(n+1,:)=(y+h*k).'; stats.nfev=stats.nfev+1; stats.n_jacobian=stats.n_jacobian+1; stats.n_linear_solve=stats.n_linear_solve+1;
end
end
