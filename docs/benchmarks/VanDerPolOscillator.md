# Van der Pol Oscillator

## Equation

```text
x' = y, y' = mu(1-x^2)y - x
```

## Implemented MATLAB file

```text
src/benchmarks/benchmark_vanderpol.m
```

## Historical background

Balthasar van der Pol introduced this nonlinear oscillator in the context of vacuum-tube electrical oscillations and relaxation oscillations.

## Mathematical properties

It tests nonlinear oscillation and stiffness transition. Small mu is non-stiff; large mu produces fast-slow behavior that favors stiff solvers.

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
