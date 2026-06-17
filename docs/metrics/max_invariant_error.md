# Maximum invariant drift (`max_invariant_error`)

## Purpose

`max_invariant_error` measures the maximum drift of a conserved or monitored quantity, such as energy, angular momentum, mass, or another invariant.

## Formula

Let $I(y)$ be the monitored invariant. At output time $t_i$, define

$$
I_i = I(y_i).
$$

Then

$$
D_{\max} = \max_i \left| I_i - I_0 \right|.
$$

The value stored in the results table as `max_invariant_error` is $D_{\max}$.

## Interpretation

This metric is especially important for Hamiltonian systems, conservative mechanics, orbital dynamics, and long-time simulations where qualitative behavior matters as much as pointwise error.
