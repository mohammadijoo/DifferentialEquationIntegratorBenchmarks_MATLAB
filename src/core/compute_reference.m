function ref = compute_reference(problem, opts)
%COMPUTE_REFERENCE Generate exact or high-accuracy reference solution.

fprintf('  [ref ] computing reference solution...\n');

t0 = problem.tspan(1);
tf = problem.tspan(2);
N = opts.metric_grid_points;
tGrid = linspace(t0, tf, N).';

if isfield(problem, 'exact') && ~isempty(problem.exact)
    Y = zeros(numel(tGrid), numel(problem.y0));
    for i = 1:numel(tGrid)
        Y(i, :) = problem.exact(tGrid(i)).';
    end
    ref.method = 'exact';
    ref.t = tGrid;
    ref.Y = Y;
    return;
end

odeOpts = odeset('RelTol', opts.ref_rtol, 'AbsTol', opts.ref_atol);
if isfield(problem, 'is_stiff') && problem.is_stiff
    solver = @ode15s;
    ref.method = 'ode15s';
else
    solver = @ode113;
    ref.method = 'ode113';
end

sol = solver(problem.f, [t0 tf], problem.y0(:), odeOpts);
Y = deval(sol, tGrid).';

ref.t = tGrid;
ref.Y = Y;
end
