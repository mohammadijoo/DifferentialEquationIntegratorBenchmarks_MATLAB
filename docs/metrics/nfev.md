# Function evaluations (`nfev`)

## Purpose

`nfev` counts evaluations of the differential-equation right-hand side or, for separable mechanical methods, the acceleration callback.

## Formula

If the callback is evaluated $m$ times during one method run, then

$$
N_f=m.
$$

## Implementation

The benchmark creates a closure-based callback wrapper with a private counter. It does not use a MATLAB global variable. Counting is performed in a separate untimed run, and `nfev_source` records whether the result came from the independent wrapper or from solver-reported statistics as a fallback.

## Interpretation

This is generally a more reproducible algorithmic work metric than elapsed time. It should still be interpreted with `n_jacobian`, `n_newton`, and `n_linear_solve`, because one right-hand-side evaluation does not capture all costs of implicit or structure-exploiting methods.
