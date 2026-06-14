# Robertson Stiff Chemical Kinetics

## Equation

```text
three-species autocatalytic reaction model
```

## Implemented MATLAB file

```text
src/benchmarks/benchmark_robertson.m
```

## Historical background

The Robertson problem is a classic stiff chemical kinetics benchmark. Its widely separated reaction rates create fast transients followed by slow evolution.

## Mathematical properties

It tests stiff-solver robustness, positivity, conservation of total mass, and efficiency of implicit or linearly implicit methods.

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
