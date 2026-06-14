function [t, Y, stats] = exponential_euler(problem, opts)
%EXPONENTIAL_EULER Exponential Rosenbrock-Euler local linearization method.
[t, Y, stats] = fixed_step_runner(problem, opts, @step, 'ExponentialEuler');
end

function [yn, info] = step(f, t, y, h, opts)
J = finite_diff_jacobian(f, t, y, opts);
A = h * J;
Phi1 = phi1_matrix(A);
yn = y + h * Phi1 * f(t, y);
info.nfev = 1 + 2*numel(y);
info.n_jacobian = 1;
end

function Phi = phi1_matrix(A)
%PHI1_MATRIX Compute phi_1(A)=(exp(A)-I)/A using solve or series fallback.
n = size(A,1);
I = eye(n);
if rcond(A) > 1e-12
    Phi = A \ (expm(A) - I);
else
    Phi = I;
    term = I;
    for k = 1:30
        term = term * A / (k + 1);
        Phi = Phi + term;
    end
end
end
