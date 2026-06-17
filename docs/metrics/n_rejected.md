# Rejected steps (`n_rejected`)

## Purpose

`n_rejected` counts adaptive trial steps rejected by a step-size controller.

## Formula

A typical adaptive method rejects a trial step when the normalized local error satisfies

$$
\eta_{\mathrm{loc}} > 1.
$$

If this happens $r$ times, define

$$
N_{\mathrm{rej}} = r.
$$

The value stored in the results table as `n_rejected` is $N_{\mathrm{rej}}$.

## Interpretation

Large values often indicate stiffness, discontinuities, poor step-size prediction, tight tolerances, or instability.
