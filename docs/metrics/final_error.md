# `final_error`

## Meaning

`final_error` measures the numerical error at the final reported time of a benchmark run.

## Mathematical definition

Let the numerical solution be \(y_N\) at final time \(t_N\), and let the exact or high-accuracy reference solution be \(y_{ref}(t_N)\). The metric is

\[
\texttt{final\_error}=\|y_N-y_{ref}(t_N)\|_2 .
\]

For scalar problems this reduces to the absolute final-time error.

## Interpretation

A smaller value means that the method lands closer to the reference solution at the final time. This is useful for accuracy testing, convergence studies, and work-precision diagrams.

## Limitations

Final-time error can hide large transient errors, phase drift, energy drift, or qualitative trajectory failure that occurs before the final time. It should be interpreted together with `max_error`, `rmse_error`, and any invariant or qualitative diagnostics.
