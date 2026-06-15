# Implicit Midpoint

## Category

Implicit Runge-Kutta / symplectic one-step method.

## Implemented MATLAB file

```text
src/methods/implicit_midpoint.m
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

$$
y_{n+1}=y_n+h f\left(t_n+\frac{h}{2},\frac{y_n+y_{n+1}}{2}\right).
$$

### Geometric meaning

The method seeks an endpoint such that the chord from $y_n$ to $y_{n+1}$ has slope equal to the vector field at the midpoint of the chord. The midpoint is not predicted explicitly; it is solved consistently.

### Accuracy

Implicit midpoint is a one-stage Gauss collocation method with

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

### Stability

For $y'=\lambda y$,

$$
R(z)=\frac{1+z/2}{1-z/2}.
$$

It is A-stable but not L-stable.

### Symplecticity

For Hamiltonian systems, implicit midpoint is symplectic. It generally keeps long-time energy error bounded around a nearby modified Hamiltonian rather than producing systematic drift.

### Pseudocode

```text
for each step:
    define the unknown endpoint Y
    evaluate f at time t+h/2 and state (y+Y)/2
    solve Y = y + h*f(midpoint)
```

## Historical background

The implicit midpoint method is a classical collocation Runge-Kutta method and is important in geometric numerical integration because it is symplectic.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Implicit Runge-Kutta / symplectic one-step method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

Hamiltonian and oscillatory systems where symmetry and symplecticity matter

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
