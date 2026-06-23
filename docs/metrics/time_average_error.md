# Time-averaged trajectory error (`time_average_error`)

## Purpose

`time_average_error` measures error over the complete integration interval rather than only at the final time. It remains informative when an inaccurate trajectory eventually reaches the correct equilibrium.

## Formula

Let

$$
e(t)=\lVert y_{\mathrm{num}}(t)-y_{\mathrm{ref}}(t)\rVert_2.
$$

For an interval from $t_0$ to $T$,

$$
E_{\mathrm{avg}}=\frac{1}{T-t_0}\int_{t_0}^{T}e(t)\,dt.
$$

The implementation evaluates this integral with the trapezoidal rule on the solver's actual output times.

## Interpretation

A small final-time error combined with a large time-averaged error indicates that the numerical solution was inaccurate during much of the simulation but later converged to the correct terminal state.
