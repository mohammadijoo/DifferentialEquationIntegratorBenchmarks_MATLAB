# `positivity_violation`

## Meaning

`positivity_violation` measures whether a numerical solution violates a nonnegative-state constraint.

## Mathematical definition

For states whose components should satisfy \(y_j(t)\ge 0\), one possible diagnostic is

\[
\texttt{positivity\_violation}=\max_{i,j}\max(0,-y_{i,j}) .
\]

A value of zero means no sampled component became negative.

## Interpretation

This metric is important for chemical concentrations, population models, probabilities, compartmental epidemic models, and other physically nonnegative states.

## Limitations

A method can be accurate in a norm but still produce small negative values. Conversely, enforcing positivity may change accuracy or conservation behavior. This metric should be interpreted with error and invariant metrics.
