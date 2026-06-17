# Positivity violation (`positivity_violation`)

## Purpose

`positivity_violation` measures how strongly a numerical solution violates nonnegative state constraints.

## Formula

For a state vector whose components should satisfy $y_j(t)\ge 0$, define

$$
P_{\max} = \max_{i,j}\max\left(0,-y_{i,j}\right).
$$

The value stored in the results table as `positivity_violation` is $P_{\max}$.

## Interpretation

This metric is important for chemical concentrations, population models, epidemic compartments, probabilities, densities, and other physical quantities that should remain nonnegative.
