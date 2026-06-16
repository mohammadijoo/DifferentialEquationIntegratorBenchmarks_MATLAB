function [tout, yout, stats] = heun_method(bench, opts)
tout = make_uniform_grid(bench.tspan, opts.h);
yout = zeros(numel(tout), numel(bench.y0)); yout(1,:) = bench.y0(:).'; nfev=0;
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); y=yout(n,:).'; t=tout(n);
    k1=bench.rhs(t,y); k2=bench.rhs(t+h,y+h*k1); nfev=nfev+2;
    yout(n+1,:)=(y+h*(k1+k2)/2).';
end
stats=basic_stats(numel(tout)-1,nfev);
end
