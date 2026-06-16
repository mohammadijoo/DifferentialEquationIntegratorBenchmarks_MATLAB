# `rmse_error`

## Meaning

`rmse_error` measures the root-mean-square trajectory error over the comparison interval.

## Mathematical definition

For errors

\[
e_i=\|y_i-y_{ref}(t_i)\|_2,
\]

the RMSE is

\[
\texttt{rmse\_error}=\sqrt{\frac{1}{N+1}\sum_{i=0}^{N} e_i^2} .
\]

## Interpretation

A smaller value means better average trajectory accuracy. This metric is useful when one wants an aggregate accuracy measure rather than only final-time or worst-case behavior.

## Limitations

RMSE can hide short but severe local failures because the error is averaged over all sampled times. Use it together with `max_error`.
