# Differential Equation Integrator Benchmarks in MATLAB

A MATLAB benchmark repository for implementing and comparing numerical integrators on classical ordinary differential equation (ODE) test problems.

The project evaluates explicit, implicit, adaptive, multistep, stiff, symplectic, splitting, and energy-oriented methods on six benchmark problems:

1. Linear decay / Dahlquist test equation
2. Harmonic oscillator
3. Van der Pol oscillator
4. Lorenz system
5. Robertson stiff chemical kinetics problem
6. Kepler two-body problem

The repository is designed for numerical-analysis education, control engineering, robotics simulation, computational physics, and scientific-computing benchmarking.

---

## What this repository does

For each benchmark problem, the framework:

- runs all applicable integrators,
- computes a high-accuracy reference trajectory,
- measures numerical error,
- measures CPU time,
- counts function evaluations,
- detects blow-up / NaN / solver failure,
- evaluates conservation-law errors when available,
- produces tables in `.csv` format,
- produces comparison plots in `.png` format.

The benchmark output is generated under:

```text
results/<BenchmarkName>/
```

---

## Repository structure

```text
.
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CITATION.cff
├── .gitignore
├── run_all.m
├── run_one_benchmark.m
├── src/
│   ├── benchmarks/       # Benchmark differential equations
│   ├── config/           # Method and benchmark registries
│   ├── core/             # Shared integration, metrics, reference, Newton utilities
│   ├── methods/          # MATLAB implementation of each integrator
│   └── plotting/         # Plot generation utilities
├── docs/
│   ├── methods/          # One Markdown file per integrator
│   ├── benchmarks/       # One Markdown file per benchmark equation
│   ├── tutorials/        # How to add methods/problems
│   └── references.md
├── tests/
│   └── test_smoke.m
└── results/              # Generated result tables and plots
```

---

## Quick start

Open MATLAB in the repository root and run:

```matlab
run_all
```

To run only one benchmark:

```matlab
run_one_benchmark('HarmonicOscillator')
run_one_benchmark('RobertsonKinetics')
run_one_benchmark('KeplerTwoBody')
```

Results are written to:

```text
results/<BenchmarkName>/
```

---

## Differential equations: short overview

Differential equations relate unknown functions to their derivatives. Major types include:

| Type | Example | Typical use |
|---|---|---|
| ODE | `dx/dt = f(t,x)` | control, mechanics, circuits, biology |
| PDE | `u_t = α u_xx` | heat, waves, fluids, electromagnetics |
| DAE | `F(t,x,x') = 0` | constrained mechanics, circuits, process systems |
| SDE | `dX = a(X)dt + b(X)dW` | finance, noise-driven physics, biology |
| Delay differential equation | `x'(t)=f(x(t),x(t-τ))` | population, control with delay |
| Hybrid differential equation | continuous dynamics + switching | robotics contact, relays, digital control |

This repository focuses on initial-value ODEs, including first-order systems and second-order mechanical systems rewritten in first-order form.

---

## Integrator families implemented

| Category | Implemented methods | Documentation |
|---|---|---|
| Basic explicit | Forward Euler, Explicit Midpoint, Heun, Ralston | [`docs/methods/ForwardEuler.md`](docs/methods/ForwardEuler.md), [`ExplicitMidpoint.md`](docs/methods/ExplicitMidpoint.md), [`Heun.md`](docs/methods/Heun.md), [`Ralston.md`](docs/methods/Ralston.md) |
| Runge-Kutta | Kutta RK3, Classical RK4, RKF45, Dormand-Prince RK45 | [`KuttaRK3.md`](docs/methods/KuttaRK3.md), [`RK4.md`](docs/methods/RK4.md), [`RKF45.md`](docs/methods/RKF45.md), [`DormandPrinceRK45.md`](docs/methods/DormandPrinceRK45.md) |
| Implicit one-step | Backward Euler, Implicit Midpoint, Trapezoidal Rule | [`BackwardEuler.md`](docs/methods/BackwardEuler.md), [`ImplicitMidpoint.md`](docs/methods/ImplicitMidpoint.md), [`TrapezoidalRule.md`](docs/methods/TrapezoidalRule.md) |
| Linear multistep | Adams-Bashforth 2, Adams-Bashforth 4, Adams-Moulton 2, ABM4 predictor-corrector, BDF2 | [`AdamsBashforth2.md`](docs/methods/AdamsBashforth2.md), [`AdamsBashforth4.md`](docs/methods/AdamsBashforth4.md), [`AdamsMoulton2.md`](docs/methods/AdamsMoulton2.md), [`ABM4PredictorCorrector.md`](docs/methods/ABM4PredictorCorrector.md), [`BDF2.md`](docs/methods/BDF2.md) |
| Stiff / linearly implicit | Rosenbrock-Euler, ROS2, Exponential Euler / exponential Rosenbrock-Euler | [`RosenbrockEuler.md`](docs/methods/RosenbrockEuler.md), [`ROS2.md`](docs/methods/ROS2.md), [`ExponentialEuler.md`](docs/methods/ExponentialEuler.md) |
| Geometric / mechanical | Symplectic Euler, Verlet, Velocity Verlet, Leapfrog, Yoshida 4, Strang splitting, Newmark-beta | [`SymplecticEuler.md`](docs/methods/SymplecticEuler.md), [`Verlet.md`](docs/methods/Verlet.md), [`VelocityVerlet.md`](docs/methods/VelocityVerlet.md), [`Leapfrog.md`](docs/methods/Leapfrog.md), [`Yoshida4.md`](docs/methods/Yoshida4.md), [`StrangSplitting.md`](docs/methods/StrangSplitting.md), [`NewmarkBeta.md`](docs/methods/NewmarkBeta.md) |
| Energy-oriented | Discrete Gradient Oscillator | [`DiscreteGradientOscillator.md`](docs/methods/DiscreteGradientOscillator.md) |

Not every method is meaningful for every benchmark. For example, Velocity Verlet is only run on separable conservative mechanical systems such as the harmonic oscillator and Kepler problem. Stiff solvers are especially meaningful for Robertson and high-parameter Van der Pol.

---

## Benchmark equations

| Benchmark | Main property tested | Documentation |
|---|---|---|
| Linear decay / Dahlquist test equation | absolute stability, order, scalar accuracy | [`LinearTestEquation.md`](docs/benchmarks/LinearTestEquation.md) |
| Harmonic oscillator | energy drift, phase error, phase portrait | [`HarmonicOscillator.md`](docs/benchmarks/HarmonicOscillator.md) |
| Van der Pol oscillator | nonlinear oscillation, stiffness transition | [`VanDerPolOscillator.md`](docs/benchmarks/VanDerPolOscillator.md) |
| Lorenz system | chaos, short-time accuracy, qualitative attractor behavior | [`LorenzSystem.md`](docs/benchmarks/LorenzSystem.md) |
| Robertson kinetics | severe stiffness, positivity, mass conservation | [`RobertsonKinetics.md`](docs/benchmarks/RobertsonKinetics.md) |
| Kepler two-body problem | orbital drift, energy and angular momentum preservation | [`KeplerTwoBody.md`](docs/benchmarks/KeplerTwoBody.md) |

---

## Performance metrics

The framework computes the following metrics whenever applicable:

| Metric | Meaning |
|---|---|
| `final_error` | norm of final-time error against exact/reference solution |
| `max_error` | maximum trajectory error over the metric window |
| `rmse_error` | root-mean-square trajectory error |
| `cpu_time` | MATLAB wall-clock time measured with `tic/toc` |
| `n_steps` | number of accepted output steps |
| `nfev` | number of right-hand-side evaluations |
| `n_rejected` | rejected adaptive steps |
| `n_jacobian` | number of numerical Jacobian evaluations |
| `n_newton` | Newton iterations used by implicit methods |
| `max_invariant_error` | maximum drift in energy, mass, or angular momentum |
| `status` | success, failure, blow-up, or non-applicable |

---

## Generated plots

For every benchmark, the plotting scripts generate:

- solution trajectory comparison,
- error versus time,
- final error bar chart,
- CPU-time bar chart,
- function-evaluation bar chart,
- work-precision diagram,
- invariant error plot when invariants exist,
- phase portrait when the benchmark has a useful phase-space representation.

---

## Important interpretation rule

There is no universal best integrator.

A good conclusion should be problem-dependent:

- RK4 and adaptive RK methods are strong for smooth non-stiff problems.
- DOPRI/RK45-style methods are excellent when automatic step control is needed.
- BDF, Radau-type, Rosenbrock, and MATLAB `ode15s`-style solvers are usually better for stiff problems.
- Symplectic and splitting methods are better for long-term conservative mechanics.
- Energy-preserving methods are useful when invariant drift is more important than pointwise trajectory error.

---

## MATLAB version

The code is written in plain MATLAB style and avoids Simulink dependencies. It should run on recent MATLAB releases. Some plotting details may need minor adjustment on very old releases.

---

## License

This project is released under the MIT License. See [`LICENSE`](LICENSE).
