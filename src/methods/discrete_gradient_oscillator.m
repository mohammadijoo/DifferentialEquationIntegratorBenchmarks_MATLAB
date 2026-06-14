function [t, Y, stats] = discrete_gradient_oscillator(problem, opts)
%DISCRETE_GRADIENT_OSCILLATOR Energy-preserving method for harmonic oscillator.
if ~strcmp(problem.name, 'HarmonicOscillator')
    error('DiscreteGradientOscillator is implemented only for HarmonicOscillator.');
end
[t, Y, stats] = mechanical_step_runner(problem, opts, @step, 'DiscreteGradientOscillator');
end

function [yn, info] = step(problem, t, y, h, opts) %#ok<INUSD>
omega = problem.params.omega;
q = y(1); v = y(2);
% Solve implicit midpoint equations exactly for the linear oscillator:
% qn - q - h/2*(v + vn) = 0
% vn - v + h/2*omega^2*(q + qn) = 0
A = [1, -h/2; h*omega^2/2, 1];
b = [q + h*v/2; v - h*omega^2*q/2];
z = A \ b;
yn = z(:);
info.nfev = 0;
info.n_linear_solve = 1;
info.success = true;
info.status = 'success';
end
