# `n_jacobian`

## Meaning

`n_jacobian` counts Jacobian evaluations.

## Mathematical definition

For an ODE or residual system, the Jacobian is typically

\[
J(t,y)=\frac{\partial f}{\partial y}(t,y).
\]

Implicit, Rosenbrock, linearly implicit, DAE, and stiff solvers may evaluate or approximate this matrix.

## Interpretation

A lower count can indicate that the method reuses Jacobians efficiently. A high count may indicate nonlinear difficulty, stiffness, or conservative solver settings.

## Limitations

One Jacobian evaluation can be cheap or expensive depending on whether it is analytic, finite-difference, sparse, dense, automatic-differentiated, or problem-specific. Count alone is not enough; cost per Jacobian matters.
