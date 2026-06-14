# Kepler Two-Body Problem

## Equation

```text
r' = v, v' = -mu r/||r||^3
```

## Implemented MATLAB file

```text
src/benchmarks/benchmark_kepler_two_body.m
```

## Historical background

The Kepler problem is the central-force two-body problem associated with Kepler's planetary laws and Newtonian gravitation.

## Mathematical properties

It tests long-term orbital stability, energy conservation, angular momentum conservation, and phase/orbital drift. Symplectic methods should perform well.

## Why it is a benchmark

This problem is included because it exposes numerical behavior that may be hidden in simpler tests. It allows comparison of:

- accuracy,
- stability,
- stiffness handling,
- phase error,
- conservation-law drift,
- positivity or physical admissibility,
- computational cost.

## Real-world applications

Depending on the equation, applications include control systems, mechanical vibration, circuits, chemical kinetics, atmospheric dynamics, celestial mechanics, robotics, and computational physics.

## Metrics emphasized in this repository

- final error,
- maximum trajectory error,
- RMS error,
- CPU time,
- function evaluations,
- failure/blow-up status,
- invariant drift when applicable,
- qualitative plots such as phase portraits or attractor projections.

## Recommended plots

- solution versus time,
- error versus time,
- work-precision diagram,
- invariant error versus time when applicable,
- phase portrait or orbit plot when applicable.

## References

See [`../references.md`](../references.md).
