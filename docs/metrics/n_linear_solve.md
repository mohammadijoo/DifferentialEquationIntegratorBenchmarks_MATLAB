# Linear solves (`n_linear_solve`)

## Purpose

`n_linear_solve` counts linear systems solved inside implicit, linearly implicit, Rosenbrock, Newton-Krylov, DAE, or PDE-derived methods.

## Formula

A typical linear solve has the form

$$
A x = b.
$$

If the solver solves such systems $s$ times, define

$$
N_{\mathrm{lin}} = s.
$$

The value stored in the results table as `n_linear_solve` is $N_{\mathrm{lin}}$.

## Interpretation

This metric is important for stiff and implicit methods because linear algebra often dominates the computational cost.
