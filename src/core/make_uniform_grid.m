function t = make_uniform_grid(tspan, h)
n = max(1, ceil((tspan(2)-tspan(1))/h));
t = linspace(tspan(1), tspan(2), n+1).';
end
