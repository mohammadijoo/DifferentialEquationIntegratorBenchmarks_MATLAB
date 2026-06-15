# Symplectic Euler

## Category

First-order symplectic method.

## Implemented MATLAB file

```text
src/methods/symplectic_euler.m
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

### Hamiltonian form

For a separable Hamiltonian

$$
H(q,p)=T(p)+V(q),
$$

the equations are

$$
\dot q=\nabla_pT(p), \qquad \dot p=-\nabla_qV(q).
$$

### Kick-drift variant

$$
p_{n+1}=p_n-h\nabla_qV(q_n),
$$

$$
q_{n+1}=q_n+h\nabla_pT(p_{n+1}).
$$

### Geometric meaning

The updated momentum is used immediately in the position update. This small change from Forward Euler makes the map symplectic, so it preserves phase-space area in canonical coordinates.

### Accuracy and energy

Symplectic Euler is first-order:

$$
\text{global error}=O(h).
$$

However, it often preserves a nearby modified Hamiltonian, giving bounded energy oscillations instead of monotone drift.

### Pseudocode

```text
for each step:
    update momentum using old position
    update position using new momentum
```

## Historical background

Symplectic Euler is a basic geometric integrator for Hamiltonian systems and illustrates how changing the update ordering can preserve phase-space structure.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the First-order symplectic method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

Hamiltonian mechanical systems where qualitative long-time behavior matters more than high local order

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
