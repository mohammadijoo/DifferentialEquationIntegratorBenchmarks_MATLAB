# Newton iterations (`n_newton`)

## Purpose

`n_newton` counts Newton or Newton-like nonlinear iterations used inside implicit methods.

## Formula

For an implicit residual equation $G(z)=0$, a Newton step commonly solves

$$
J_G(z_k)\Delta z_k = -G(z_k),
$$

then updates

$$
z_{k+1}=z_k+\Delta z_k.
$$

If these nonlinear iterations occur $p$ times over a run, define

$$
N_{\mathrm{Newton}} = p.
$$

The value stored in the results table as `n_newton` is $N_{\mathrm{Newton}}$.

## Interpretation

Large values can indicate stiffness, poor initial guesses, too-large steps, or difficult nonlinear residuals.
