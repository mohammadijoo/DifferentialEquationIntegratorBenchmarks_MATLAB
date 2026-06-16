function [tout, yout, stats] = ralston_method(bench, opts)
tout = make_uniform_grid(bench.tspan, opts.h);
yout = zeros(numel(tout), numel(bench.y0)); yout(1,:) = bench.y0(:).'; nfev=0;
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); y=yout(n,:).'; t=tout(n);
    k1=bench.rhs(t,y); k2=bench.rhs(t+2*h/3,y+2*h*k1/3); nfev=nfev+2;
    yout(n+1,:)=(y+h*(k1/4+3*k2/4)).';
end
stats=basic_stats(numel(tout)-1,nfev);
end
