function [tout, yout, stats] = yoshida4_method(bench, opts)
% Fourth-order Yoshida composition implemented through velocity-Verlet substeps.
w1 = 1/(2-2^(1/3)); w0 = -2^(1/3)/(2-2^(1/3)); coeffs=[w1 w0 w1];
tout=make_uniform_grid(bench.tspan,opts.h); [q,v]=mechanical_initial_state(bench); d=numel(q);
yout=zeros(numel(tout),2*d); yout(1,:)=[q;v].'; nfev=0;
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); t=tout(n);
    for c=coeffs
        hc=c*h; a0=bench.mechanical.acceleration(t,q); nfev=nfev+1;
        qnew=q+hc*v+0.5*hc*hc*a0; a1=bench.mechanical.acceleration(t+hc,qnew); nfev=nfev+1;
        v=v+0.5*hc*(a0+a1); q=qnew; t=t+hc;
    end
    yout(n+1,:)=[q;v].';
end
stats=basic_stats(numel(tout)-1,nfev);
end
