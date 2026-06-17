# CPU time (`cpu_time`)

## Purpose

`cpu_time` stores the elapsed MATLAB execution time for one method on one benchmark.

## Formula

Let $t_{\mathrm{start}}$ and $t_{\mathrm{stop}}$ be the times recorded before and after the solver call. Define

$$
T_{\mathrm{CPU}} = t_{\mathrm{stop}} - t_{\mathrm{start}}.
$$

The value stored in the results table as `cpu_time` is $T_{\mathrm{CPU}}$.

## Interpretation

Timing is affected by MATLAB overhead, implementation style, hardware, operating-system load, JIT warm-up, plotting, and memory allocation. It should not be used alone.

## Use with

Use together with `nfev`, `n_steps`, `n_rejected`, `n_jacobian`, `n_newton`, and `n_linear_solve`.
