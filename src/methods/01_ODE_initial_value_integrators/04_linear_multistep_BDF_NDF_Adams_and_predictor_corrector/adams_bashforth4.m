function [tout, yout, stats] = adams_bashforth4(bench, opts)
[tout,yout,stats]=rk4_method(bench,opts);
f=cell(4,1); stats=basic_stats(numel(tout)-1,0);
for i=1:min(4,numel(tout)), f{i}=bench.rhs(tout(i),yout(i,:).'); stats.nfev=stats.nfev+1; end
h=tout(2)-tout(1);
for n=4:numel(tout)-1
    yout(n+1,:)=yout(n,:)+h*(55*f{4}.'-59*f{3}.'+37*f{2}.'-9*f{1}.')/24;
    f{1}=f{2}; f{2}=f{3}; f{3}=f{4}; f{4}=bench.rhs(tout(n+1),yout(n+1,:).'); stats.nfev=stats.nfev+1;
end
end
