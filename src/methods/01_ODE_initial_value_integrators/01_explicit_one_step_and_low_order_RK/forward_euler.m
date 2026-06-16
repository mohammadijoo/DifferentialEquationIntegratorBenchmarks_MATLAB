function [tout, yout, stats] = forward_euler(bench, opts)
tout = make_uniform_grid(bench.tspan, opts.h);
yout = zeros(numel(tout), numel(bench.y0));
yout(1,:) = bench.y0(:).';
nfev = 0;
for n = 1:numel(tout)-1
    h = tout(n+1)-tout(n);
    f = bench.rhs(tout(n), yout(n,:).'); nfev = nfev + 1;
    yout(n+1,:) = yout(n,:) + h*f(:).';
end
stats = basic_stats(numel(tout)-1, nfev);
end
