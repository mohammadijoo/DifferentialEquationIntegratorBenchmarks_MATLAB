function ref = compute_reference_solution(bench, opts)
%COMPUTE_REFERENCE_SOLUTION Create high-accuracy reference trajectory.
ref = struct();
if isfield(bench, 'exact') && isa(bench.exact, 'function_handle')
    t = linspace(bench.tspan(1), bench.tspan(2), opts.n_output).';
    y = zeros(numel(t), numel(bench.y0));
    for i = 1:numel(t)
        y(i,:) = bench.exact(t(i)).';
    end
    ref.t = t;
    ref.y = y;
    ref.source = 'exact';
    return;
end

odeOpts = odeset('RelTol', opts.tol_ref, 'AbsTol', opts.tol_ref);
if isfield(bench, 'stiff') && bench.stiff
    solver = @ode15s;
else
    solver = @ode45;
end
[t,y] = solver(@(t,y) bench.rhs(t,y), bench.tspan, bench.y0(:), odeOpts);
ref.t = t;
ref.y = y;
ref.source = func2str(solver);
end
