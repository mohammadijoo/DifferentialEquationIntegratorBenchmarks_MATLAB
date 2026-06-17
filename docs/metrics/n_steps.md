# Step count (`n_steps`)

## Purpose

`n_steps` counts accepted integration steps, or output intervals when a method does not expose an internal step counter.

## Formula

For a fixed-step method with output times $t_0,t_1,\ldots,t_N$,

$$
N_{\mathrm{steps}} = N.
$$

For an adaptive method, a more precise interpretation is

$$
N_{\mathrm{steps}} = N_{\mathrm{accepted}}.
$$

The value stored in the results table as `n_steps` is $N_{\mathrm{steps}}$.

## Interpretation

This metric should be interpreted carefully because solver interfaces may report steps differently. Use together with `n_rejected`, `nfev`, and `cpu_time`.
