function problem = benchmark_harmonic_oscillator()
%BENCHMARK_HARMONIC_OSCILLATOR Conservative oscillator q'' + omega^2 q = 0.

omega = 1;
y0 = [1; 0]; % [q; v]

problem.name = 'HarmonicOscillator';
problem.title = 'Harmonic oscillator';
problem.f = @(t, y) [y(2); -omega^2 * y(1)];
problem.tspan = [0, 50];
problem.y0 = y0;
problem.default_h = 0.05;
problem.h_max = 0.2;
problem.is_stiff = false;
problem.exact = @(t) [cos(omega*t); -omega*sin(omega*t)];
problem.params.omega = omega;

problem.mechanical.is_separable = true;
problem.mechanical.q_dim = 1;
problem.mechanical.v_dim = 1;
problem.mechanical.accel = @(t, q) -omega^2 * q;

problem.invariants = struct('name', 'Energy', ...
    'fun', @(t, y) 0.5*y(2)^2 + 0.5*omega^2*y(1)^2);
problem.positivity_indices = [];
end
