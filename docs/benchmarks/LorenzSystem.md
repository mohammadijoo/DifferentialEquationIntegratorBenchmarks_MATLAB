# Lorenz System

## Equation

```text
x'=sigma(y-x), y'=x(rho-z)-y, z'=xy-beta z
```

## Implemented MATLAB file

```text
src/benchmarks/benchmark_lorenz.m
```

## Historical background

Edward Lorenz introduced this three-dimensional system in 1963 as a simplified model of deterministic nonperiodic flow.

## Mathematical properties

It tests chaotic sensitivity. Long-time pointwise error is not a fair sole metric; short-time error and attractor-level qualitative behavior are more meaningful.

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
