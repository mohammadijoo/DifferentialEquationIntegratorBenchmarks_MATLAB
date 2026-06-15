# Tau-Leaping

## Category

Approximate stochastic simulation for reaction networks..

## Implementation status

Not implemented in the current repository yet.

## Implemented MATLAB file

```text
Not implemented yet. Suggested future file: src/methods/tau_leaping.m
```

## Full mathematical explanation

### Problem setting and notation

A stochastic differential equation is commonly written as

$$
dX=a(t,X)\,dt+b(t,X)\,dW_t.
$$

A one-step stochastic method advances from $X_n$ to $X_{n+1}$ using both deterministic drift increments and random Wiener increments $\Delta W_n$.

### Core idea

Tau-Leaping should be understood as part of the **Approximate stochastic simulation for reaction networks.** class. In a benchmark suite, its purpose is not only to produce a trajectory, but also to expose how this class behaves with respect to stability, accuracy, robustness, and computational work.

### Accuracy and convergence

The relevant accuracy concept depends on the equation class. For classical ODE IVPs, local and global truncation error are usually measured in powers of the time step $h$. For DAEs, PDE semi-discretizations, SDEs, DDEs, and nonlinear algebraic components, convergence may also depend on consistency, constraint residuals, stochastic strong/weak error, spatial resolution, or nonlinear-solver tolerances.

### Stability and robustness

Stability should be evaluated on representative test problems rather than by final-time error alone. Useful tests include the Dahlquist test equation, stiff chemical kinetics, oscillatory Hamiltonian systems, constrained systems, advection/diffusion PDEs, stochastic trajectories, and nonlinear residual solves.

### Pseudocode

```text
for each step:
    evaluate the method-specific stages or residuals
    solve any required algebraic systems
    update the state
    record cost and accuracy metrics
```

## Historical background

Tau-Leaping belongs to a broader numerical-analysis literature on time integration, nonlinear equation solving, differential-algebraic equations, partial differential equations, stochastic models, or structure-preserving computation. The documentation here is intended as a practical engineering summary for benchmark planning.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Extends the benchmark coverage into Approximate stochastic simulation for reaction networks..

- Provides a candidate for future MATLAB implementation and comparison.

- Helps separate method behavior from problem-class behavior.

## Weaknesses and limitations

- This documentation file describes a candidate method; it is not implemented in the current MATLAB codebase yet.

- No single integrator or solver component is best for all differential equations.

- Performance depends on tolerances, step-size policy, Jacobian handling, and implementation details.

- Fair benchmarking should report both accuracy and work metrics.

## Works best for

stochastic models where pathwise or weak statistical error is the target metric

## Main performance metrics for this method

Useful metrics include:

- final-time error,

- maximum trajectory error,

- RMS trajectory error,

- CPU time,

- number of right-hand-side evaluations,

- accepted and rejected steps,

- Jacobian evaluations,

- linear solves and backsolves,

- Newton or nonlinear iterations,

- memory use,

- constraint residuals when applicable,

- energy or invariant drift when applicable,

- failure rate on stiff or unstable tests,

## Interpretation in this repository

In generated benchmark plots or future benchmark extensions, interpret this method by problem class:

- On non-stiff equations, compare error per CPU time.

- On stiff equations, check whether the method survives without tiny step sizes.

- On conservative mechanics, check energy/invariant drift rather than only pointwise error.

- On DAEs and constrained systems, check algebraic residuals and constraint drift.

- On PDE-derived systems, separate spatial-discretization error from time-integration error.

- On stochastic systems, distinguish strong pathwise error from weak/statistical error.

- On nonlinear solver components, report iterations, convergence failures, and linear-solve work.

## References

See [`../references.md`](../references.md).
