# `nfev`

## Meaning

`nfev` counts right-hand-side function evaluations.

## Mathematical / implementation meaning

For an ODE

\[
y'=f(t,y),
\]

`nfev` counts calls to \(f(t,y)\). In Runge-Kutta methods this is closely related to the number of stages times the number of accepted and rejected steps.

## Interpretation

A lower `nfev` often means less RHS work, especially when RHS evaluation is expensive.

## Limitations

`nfev` does not capture Jacobian assembly, matrix factorization, Newton iterations, linear solves, event handling, or interpolation overhead. For stiff and implicit methods, combine it with `n_jacobian`, `n_newton`, and `n_linear_solve`.
