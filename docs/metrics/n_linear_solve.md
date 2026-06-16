# `n_linear_solve`

## Meaning

`n_linear_solve` counts linear solves or backsolves used inside implicit, linearly implicit, Rosenbrock, Newton, or preconditioned methods.

## Mathematical context

Typical linear solves have the form

\[
A x=b .
\]

In implicit ODE methods, \(A\) may be a Jacobian-derived matrix such as \(I-h\gamma J\).

## Interpretation

A lower count can indicate less linear algebra work. For stiff systems, this count is often more informative than raw RHS evaluations.

## Limitations

The cost of a linear solve depends heavily on matrix size, sparsity, conditioning, factorization reuse, preconditioning, and direct versus iterative solution strategy.
