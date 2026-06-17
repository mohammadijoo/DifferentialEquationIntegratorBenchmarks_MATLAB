# Root-mean-square trajectory error (`rmse_error`)

## Purpose

`rmse_error` summarizes the average trajectory error over the reported output times.

## Formula

For pointwise errors $e_i$, define

$$
E_{\mathrm{rms}} = \sqrt{\frac{1}{N}\sum_{i=1}^{N} e_i^2}.
$$

The value stored in the results table as `rmse_error` is $E_{\mathrm{rms}}$.

## Interpretation

This metric reflects overall trajectory accuracy and is usually less dominated by one isolated error spike than `max_error`.
