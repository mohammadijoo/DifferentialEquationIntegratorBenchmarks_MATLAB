function b = benchmark_swift_hohenberg_equation()
%BENCHMARK_SWIFT_HOHENBERG_EQUATION Fourier-spectral stiff PDE benchmark.
% The periodic Swift-Hohenberg equation is discretized in space, producing a
% 128-dimensional stiff ODE system for the time integrators.

N = 128;
domain_length = 32*pi;
r = 0.3;
x = domain_length*(0:N-1)'/N;
mode_numbers = [0:(N/2-1), 0, -(N/2-1):-1].';
k = (2*pi/domain_length)*mode_numbers;
linear_symbol = r - (1-k.^2).^2;
u0 = 0.1*cos(x) + 0.01*cos(2*x) + 0.001*cos(7*x);

b = struct();
b.name = 'SwiftHohenbergEquation';
b.displayName = 'Swift-Hohenberg Equation (Fourier Spectral MOL)';
b.equationClass = 'pde_mol';
b.tspan = [0 10];
b.y0 = u0;
b.rhs = @(t,u) swift_hohenberg_rhs(u, linear_symbol);
b.stiff = true;
b.implemented = true;
b.exact = [];
b.invariant = [];
b.grid.x = x;
b.grid.domain_length = domain_length;
b.grid.n_points = N;
b.spatial_discretization = 'Fourier pseudospectral';
b.params.r = r;
b.params.wavenumbers = k;
end

function du = swift_hohenberg_rhs(u, linear_symbol)
u_hat = fft(u);
nonlinear_hat = fft(u.^3);
du = real(ifft(linear_symbol.*u_hat - nonlinear_hat));
end
