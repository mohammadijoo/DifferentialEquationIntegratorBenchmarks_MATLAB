# Final error (`final_error`)

## Purpose

`final_error` measures the numerical error at the final reported time of a benchmark run.

## Formula

Let the numerical solution at the final time be $y_N$, and let the exact or high-accuracy reference solution be $y_{\mathrm{ref}}(t_N)$. Define

$$
E_{\mathrm{final}} = \left\lVert y_N - y_{\mathrm{ref}}(t_N) \right\rVert_2.
$$

The value stored in the results table as `final_error` is $E_{\mathrm{final}}$.

## Interpretation

A smaller value usually means better final-time accuracy. However, this metric can hide transient errors, phase drift, invariant drift, or qualitative trajectory failure before the final time.

## Use with

Use together with `max_error`, `rmse_error`, `max_invariant_error`, and trajectory plots.
