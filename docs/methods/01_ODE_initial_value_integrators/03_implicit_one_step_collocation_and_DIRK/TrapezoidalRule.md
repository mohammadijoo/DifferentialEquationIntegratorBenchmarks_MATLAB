# Trapezoidal Rule

## Category

Implicit second-order one-step method.

## Implemented MATLAB file

```text
src/methods/trapezoidal_rule.m
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
y_{n+1}=y_n+\frac{h}{2}\left[f(t_n,y_n)+f(t_{n+1},y_{n+1})\right].
$$

### Geometric meaning

The exact step is an integral of the vector field. The trapezoidal rule approximates this integral by averaging the endpoint slopes. The method is implicit because the endpoint slope is unknown before solving for $y_{n+1}$.

### Accuracy

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

### Stability

For $y'=\lambda y$,

$$
R(z)=\frac{1+z/2}{1-z/2}.
$$

The method is A-stable but not L-stable. It is less dissipative than Backward Euler, which can be good for oscillations but less effective for killing very stiff transients.

### Time symmetry

For autonomous systems, the method is symmetric: a forward step of size $h$ followed by a step of size $-h$ returns to the starting value up to solver tolerance.

### Pseudocode

```text
for each step:
    form the endpoint-slope averaged residual
    solve for the future state
    accept the future state
```

## Historical background

The trapezoidal rule originates from classical numerical quadrature and becomes an implicit ODE method when applied to the integral form of an initial-value problem.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Implicit second-order one-step method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth mildly stiff problems where second-order accuracy and low numerical damping are desired

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
