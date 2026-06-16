# `n_rejected`

## Meaning

`n_rejected` counts rejected adaptive steps.

## Implementation meaning

A rejected step occurs when an adaptive method estimates that a proposed step violates the requested tolerance or stability/validity criteria, then discards that step and retries with a smaller or modified step.

## Interpretation

A high value may indicate stiffness, discontinuities, poor error estimates, overly aggressive step-size growth, or tolerance settings that are difficult for the method.

## Limitations

Fixed-step methods usually have zero rejected steps. Some solvers may not expose this count, so the value may be unavailable or set to zero depending on the implementation.
