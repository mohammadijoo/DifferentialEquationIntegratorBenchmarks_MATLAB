# Jacobian evaluations (`n_jacobian`)

## Purpose

`n_jacobian` counts Jacobian evaluations used by implicit, linearly implicit, Newton, Rosenbrock, DAE, or stiff solver components.

## Formula

For an ODE system $y'=f(t,y)$, the Jacobian is

$$
J(t,y)=\frac{\partial f}{\partial y}(t,y).
$$

If the solver forms or approximates this matrix $q$ times, define

$$
N_J = q.
$$

The value stored in the results table as `n_jacobian` is $N_J$.

## Interpretation

Analytic, finite-difference, sparse, dense, and reused Jacobians have very different costs. Interpret this metric together with `cpu_time`, `n_newton`, and `n_linear_solve`.
