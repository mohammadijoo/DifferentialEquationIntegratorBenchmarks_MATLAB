function [tout, yout, stats] = abm4_predictor_corrector(bench, opts)
[tout,yout,stats]=rk4_method(bench,opts);
f=cell(4,1); stats=basic_stats(numel(tout)-1,0);
for i=1:min(4,numel(tout)), f{i}=bench.rhs(tout(i),yout(i,:).'); stats.nfev=stats.nfev+1; end
h=tout(2)-tout(1);
for n=4:numel(tout)-1
    yp=yout(n,:).'+h*(55*f{4}-59*f{3}+37*f{2}-9*f{1})/24;
    fp=bench.rhs(tout(n+1),yp); stats.nfev=stats.nfev+1;
    yc=yout(n,:).'+h*(9*fp+19*f{4}-5*f{3}+f{2})/24;
    yout(n+1,:)=yc.';
    f{1}=f{2}; f{2}=f{3}; f{3}=f{4}; f{4}=bench.rhs(tout(n+1),yc); stats.nfev=stats.nfev+1;
end
end
