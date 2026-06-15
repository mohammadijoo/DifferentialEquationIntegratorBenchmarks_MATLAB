# Verlet

## Category

Second-order position-based symplectic method.

## Implemented MATLAB file

```text
src/methods/verlet.m
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

### Formula

For

$$
\ddot q=a(q),
$$

Verlet uses

$$
q_{n+1}=2q_n-q_{n-1}+h^2a(q_n).
$$

Velocity can be estimated by

$$
v_n\approx \frac{q_{n+1}-q_{n-1}}{2h}.
$$

### Geometric meaning

The method continues the previous displacement and bends it by the current acceleration. It is a centered second-difference approximation to Newton's equation.

### Taylor derivation

Adding the Taylor expansions of $q(t_n+h)$ and $q(t_n-h)$ gives

$$
q(t_n+h)=2q(t_n)-q(t_n-h)+h^2\ddot q(t_n)+O(h^4).
$$

Substituting $a(q_n)$ gives the Verlet recurrence.

### Accuracy and structure

Verlet is globally second-order and symplectic for separable Hamiltonian mechanical systems.

### Startup

Because the formula uses $q_{n-1}$, an initial second point must be constructed from $q_0$, $v_0$, and $a(q_0)$.

### Pseudocode

```text
initialize q0 and q1
for each step:
    compute acceleration at q_n
    compute q_{n+1}=2*q_n-q_{n-1}+h^2*a(q_n)
```

## Historical background

Verlet integration is widely associated with molecular dynamics and classical mechanics, where position-only second-order equations are common.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Second-order position-based symplectic method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

second-order mechanical systems where acceleration depends mainly on position

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
