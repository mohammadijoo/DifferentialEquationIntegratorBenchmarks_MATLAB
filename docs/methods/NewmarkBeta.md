# Newmark-beta

## Category

Second-order structural dynamics method.

## Implemented MATLAB file

```text
src/methods/newmark_beta.m
```

## Core idea

Parameter family; average acceleration β=1/4, γ=1/2 is common and unconditionally stable for linear problems.

The method advances an initial-value problem

```text
y' = f(t, y),    y(t0) = y0
```

from `t_n` to `t_(n+1)=t_n+h` using the method-specific update formula implemented in the MATLAB file above.

## Historical background

Nathan M. Newmark introduced the method in 1959 for structural dynamics.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Second-order structural dynamics method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

structural dynamics, vibrations, finite element dynamics

## Main performance metrics for this method

Useful metrics include:

- final-time error,
- maximum trajectory error,
- RMS trajectory error,
- CPU time,
- number of right-hand-side evaluations,
- rejected steps for adaptive variants,
- Newton iterations for implicit variants,
- energy or invariant drift when applicable,
- failure rate on stiff or unstable tests.

## Interpretation in this repository

In the generated benchmark plots, this method should be interpreted by problem class:

- On non-stiff equations, compare error per CPU time.
- On stiff equations, check whether the method survives without tiny step sizes.
- On conservative mechanics, check energy/invariant drift rather than only pointwise error.
- On chaotic equations, use short-time error and long-time qualitative behavior.

## References

See [`../references.md`](../references.md).
