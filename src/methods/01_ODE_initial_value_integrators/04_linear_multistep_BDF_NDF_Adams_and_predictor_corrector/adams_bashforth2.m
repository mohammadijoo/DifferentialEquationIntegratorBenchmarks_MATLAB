function [tout, yout, stats] = adams_bashforth2(bench, opts)
[tout,yout,stats]=rk4_method(bench,opts); yout(:)=0; yout(1,:)=bench.y0(:).';
y0=yout(1,:).'; h=tout(2)-tout(1); f0=bench.rhs(tout(1),y0); yout(2,:)=(y0+h*f0).'; fprev=f0; stats=basic_stats(numel(tout)-1,1);
for n=2:numel(tout)-1
    fn=bench.rhs(tout(n),yout(n,:).'); stats.nfev=stats.nfev+1;
    yout(n+1,:)=yout(n,:)+h*(3*fn.'-fprev.')/2; fprev=fn;
end
end
