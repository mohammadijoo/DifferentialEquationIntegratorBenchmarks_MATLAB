# Maximum trajectory error (`max_error`)

## Purpose

`max_error` measures the largest pointwise trajectory error over all reported output times.

## Formula

For output times $t_i$, numerical states $y_i$, and reference states $y_{\mathrm{ref}}(t_i)$, define

$$
e_i = \left\lVert y_i - y_{\mathrm{ref}}(t_i) \right\rVert_2.
$$

Then

$$
E_{\max} = \max_i e_i.
$$

The value stored in the results table as `max_error` is $E_{\max}$.

## Interpretation

This metric is useful for detecting the worst local error over the whole trajectory. It can be sensitive to isolated spikes or interpolation mismatch, so it should be interpreted together with `rmse_error` and error-versus-time plots.
