function [tout, yout, stats] = symplectic_euler(bench, opts)
tout=make_uniform_grid(bench.tspan,opts.h); [q,v]=mechanical_initial_state(bench); d=numel(q);
yout=zeros(numel(tout),2*d); yout(1,:)=[q;v].'; nfev=0;
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); a=bench.mechanical.acceleration(tout(n),q); nfev=nfev+1;
    v=v+h*a; q=q+h*v; yout(n+1,:)=[q;v].';
end
stats=basic_stats(numel(tout)-1,nfev);
end
