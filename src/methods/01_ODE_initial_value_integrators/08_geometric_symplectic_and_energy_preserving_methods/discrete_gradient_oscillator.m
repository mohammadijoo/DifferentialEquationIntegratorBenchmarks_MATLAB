function [tout, yout, stats] = discrete_gradient_oscillator(bench, opts)
% Energy-preserving Cayley update for q'' + omega^2 q = 0.
tout=make_uniform_grid(bench.tspan,opts.h); omega=bench.params.omega; q=bench.mechanical.q0; v=bench.mechanical.v0;
yout=zeros(numel(tout),2); yout(1,:)=[q v];
for n=1:numel(tout)-1
    h=tout(n+1)-tout(n); A=[0 1; -omega^2 0]; M=(eye(2)-0.5*h*A)\(eye(2)+0.5*h*A);
    y=M*[q;v]; q=y(1); v=y(2); yout(n+1,:)=[q v];
end
stats=basic_stats(numel(tout)-1,0);
end
