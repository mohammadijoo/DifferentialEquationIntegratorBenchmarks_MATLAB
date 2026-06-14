# Linear Decay / Dahlquist Test Equation

## Equation

```text
x' = lambda x
```

## Implemented MATLAB file

```text
src/benchmarks/benchmark_linear_decay.m
```

## Historical background

The scalar linear test equation is the classical model for absolute stability analysis. It reveals how the product z=h*lambda controls numerical amplification.

## Mathematical properties

It is used for stability regions, convergence order, and stiff decay experiments. Real systems with locally linear stable modes often reduce to this behavior near an equilibrium.

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
