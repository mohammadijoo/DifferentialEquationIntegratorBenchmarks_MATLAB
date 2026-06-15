# Leapfrog

## Category

Second-order symplectic method.

## Implemented MATLAB file

```text
src/methods/leapfrog.m
```

## Full mathematical explanation

### Problem setting and notation

For an initial-value problem,

$$
y'(t)=f(t,y(t)), \qquad y(t_0)=y_0,
$$

choose grid points

$$
t_n=t_0+nh, \qquad h=t_{n+1}-t_n,
$$

and denote the numerical approximation to $y(t_n)$ by $y_n$. For a system of $m$ equations, $y_n\in\mathbb{R}^m$ and $f(t,y)\in\mathbb{R}^m$. The same formulas apply componentwise unless the method is written in special second-order mechanical variables such as position $q$, velocity $v$, and momentum $p$.

### Kick-drift-kick form

For $\dot q=M^{-1}p$ and $\dot p=F(q)$,

$$
p_{n+1/2}=p_n+\frac{h}{2}F(q_n),
$$

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},
$$

$$
p_{n+1}=p_{n+1/2}+\frac{h}{2}F(q_{n+1}).
$$

### Geometric meaning

Momentum and position leap over each other on staggered half time levels. The symmetric half-kicks around the full drift make the method time-reversible and symplectic.

### Accuracy

Leapfrog has

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

### Energy behavior

For Hamiltonian systems, leapfrog normally gives bounded oscillatory energy error rather than monotonic energy drift. This is essential for long-time orbital simulations.

### Pseudocode

```text
for each step:
    half-step momentum kick
    full-step position drift
    half-step momentum kick
```

## Historical background

Leapfrog methods have long been used in celestial mechanics, molecular dynamics, and wave problems because of their time-centered, symplectic structure.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Second-order symplectic method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

separable Hamiltonian systems, orbital dynamics, oscillators, and long-time conservative simulations

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
