function problem = benchmark_kepler_two_body()
%BENCHMARK_KEPLER_TWO_BODY Planar Kepler two-body problem in normalized units.

mu = 1;
e = 0.6;
r0 = [1 - e; 0];
v0 = [0; sqrt((1 + e)/(1 - e))];
y0 = [r0; v0];

problem.name = 'KeplerTwoBody';
problem.title = 'Kepler two-body problem';
problem.f = @(t, y) [y(3:4); kepler_accel(mu, y(1:2))];
problem.tspan = [0, 20*pi];
problem.y0 = y0;
problem.default_h = 0.01;
problem.h_max = 0.1;
problem.is_stiff = false;
problem.exact = [];
problem.params.mu = mu;
problem.params.eccentricity = e;

problem.mechanical.is_separable = true;
problem.mechanical.q_dim = 2;
problem.mechanical.v_dim = 2;
problem.mechanical.accel = @(t, q) kepler_accel(mu, q);

problem.invariants = [ ...
    struct('name', 'Energy', 'fun', @(t, y) 0.5*sum(y(3:4).^2) - mu/norm(y(1:2))), ...
    struct('name', 'AngularMomentum', 'fun', @(t, y) y(1)*y(4) - y(2)*y(3)) ...
];
problem.positivity_indices = [];
end

function a = kepler_accel(mu, r)
rn = norm(r);
a = -mu * r / rn^3;
end
