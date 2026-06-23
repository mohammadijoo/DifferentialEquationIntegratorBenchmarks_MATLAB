# Root-mean-square trajectory error (`rmse_error`)

## Purpose

`rmse_error` summarizes trajectory accuracy over the complete integration interval. It is time-weighted so adaptive solvers are not favored or penalized merely because they report more points in difficult regions.

## Formula

Let

$$
e(t)=\lVert y_{\mathrm{num}}(t)-y_{\mathrm{ref}}(t)\rVert_2.
$$

The time-weighted RMS error is

$$
E_{\mathrm{rms}}=\sqrt{\frac{1}{T-t_0}\int_{t_0}^{T}e(t)^2\,dt}.
$$

The implementation uses trapezoidal quadrature on the solver's actual output times.

## Interpretation

This metric reflects overall trajectory accuracy, emphasizes sustained large errors more strongly than `time_average_error`, and is less dependent on output-grid density than an unweighted sample average.
