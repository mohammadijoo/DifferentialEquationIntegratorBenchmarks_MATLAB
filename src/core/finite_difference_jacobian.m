function J = finite_difference_jacobian(fun, x, opts)
%FINITE_DIFFERENCE_JACOBIAN Centered finite-difference Jacobian.
if nargin < 3 || ~isfield(opts, 'fd_eps'), eps0 = sqrt(eps); else, eps0 = opts.fd_eps; end
x = x(:);
f0 = fun(x); %#ok<NASGU>
n = numel(x);
J = zeros(numel(fun(x)), n);
for j = 1:n
    dx = zeros(n,1);
    step = eps0 * max(1, abs(x(j)));
    dx(j) = step;
    J(:,j) = (fun(x+dx) - fun(x-dx)) / (2*step);
end
end
