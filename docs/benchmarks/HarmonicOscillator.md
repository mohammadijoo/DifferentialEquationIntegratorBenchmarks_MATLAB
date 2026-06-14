# Harmonic Oscillator

## Equation

```text
q' = v, v' = -omega^2 q
```

## Implemented MATLAB file

```text
src/benchmarks/benchmark_harmonic_oscillator.m
```

## Historical background

The harmonic oscillator is one of the fundamental models of mechanics, vibration, circuits, and wave phenomena. Its exact solution is periodic and conserves quadratic energy.

## Mathematical properties

It is ideal for comparing energy drift, phase error, and phase portraits. Symplectic and energy-preserving methods should show clear advantages over dissipative or unstable methods.

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
