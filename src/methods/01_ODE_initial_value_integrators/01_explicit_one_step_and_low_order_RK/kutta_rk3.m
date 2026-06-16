function [tout, yout, stats] = kutta_rk3(bench, opts)
tout = make_uniform_grid(bench.tspan, opts.h);
yout = zeros(numel(tout), numel(bench.y0)); yout(1,:) = bench.y0(:).'; nfev=0;
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); y=yout(n,:).'; t=tout(n);
    k1=bench.rhs(t,y); k2=bench.rhs(t+h/2,y+h*k1/2); k3=bench.rhs(t+h,y-h*k1+2*h*k2); nfev=nfev+3;
    yout(n+1,:)=(y+h*(k1+4*k2+k3)/6).';
end
stats=basic_stats(numel(tout)-1,nfev);
end
