# `n_newton`

## Meaning

`n_newton` counts Newton or nonlinear iterations used by implicit methods.

## Mathematical context

Implicit methods often require solving nonlinear equations such as

\[
G(z)=0.
\]

Newton's method updates an iterate by solving

\[
J_G(z_k)\Delta z_k=-G(z_k), \qquad z_{k+1}=z_k+\Delta z_k .
\]

`n_newton` counts these nonlinear iterations.

## Interpretation

A lower count usually indicates easier nonlinear solves or better initial guesses. A high count may indicate stiffness, large step sizes, poor Jacobians, or difficult nonlinear dynamics.

## Limitations

Newton iterations are not all equally expensive. Each iteration may require Jacobian evaluation, factorization, or linear solves.
