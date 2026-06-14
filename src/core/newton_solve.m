function [x, info] = newton_solve(residualFun, x0, opts)
%NEWTON_SOLVE Finite-difference Newton method for small implicit ODE systems.

x = x0(:);
info.n_newton = 0;
info.n_jacobian = 0;
info.n_linear_solve = 0;
info.success = true;
info.status = 'success';

for k = 1:opts.newton_maxit
    r = residualFun(x);
    nr = norm(r, inf);
    if nr < opts.newton_tol
        info.n_newton = k - 1;
        return;
    end

    J = residual_jacobian(residualFun, x, opts);
    info.n_jacobian = info.n_jacobian + 1;

    dx = -J \ r;
    info.n_linear_solve = info.n_linear_solve + 1;

    alpha = 1.0;
    xTrial = x + alpha * dx;
    rTrial = residualFun(xTrial);
    while norm(rTrial, inf) > (1 - 1e-4 * alpha) * nr && alpha > 1e-4
        alpha = 0.5 * alpha;
        xTrial = x + alpha * dx;
        rTrial = residualFun(xTrial);
    end

    x = xTrial;
    info.n_newton = k;

    if norm(dx, inf) < opts.newton_tol * max(1, norm(x, inf))
        return;
    end
end

info.success = false;
info.status = 'newton_failed';
end

function J = residual_jacobian(residualFun, x, opts)
n = numel(x);
J = zeros(n, n);
eps0 = opts.fd_eps;
for j = 1:n
    dx = zeros(n, 1);
    step = eps0 * max(1, abs(x(j)));
    dx(j) = step;
    rp = residualFun(x + dx);
    rm = residualFun(x - dx);
    J(:, j) = (rp - rm) / (2 * step);
end
end
