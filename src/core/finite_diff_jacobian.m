function J = finite_diff_jacobian(f, t, y, opts)
%FINITE_DIFF_JACOBIAN Central finite-difference Jacobian df/dy.

if nargin < 4 || ~isfield(opts, 'fd_eps')
    eps0 = 1e-7;
else
    eps0 = opts.fd_eps;
end

n = numel(y);
J = zeros(n, n);
for j = 1:n
    dy = zeros(n, 1);
    step = eps0 * max(1, abs(y(j)));
    dy(j) = step;
    fp = f(t, y + dy);
    fm = f(t, y - dy);
    J(:, j) = (fp - fm) / (2 * step);
end
end
