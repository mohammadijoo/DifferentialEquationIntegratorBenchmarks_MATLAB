# Explicit Midpoint

## Category

Explicit Runge-Kutta method.

## Implemented MATLAB file

```text
src/methods/explicit_midpoint.m
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

### Stage formulas

$$
k_1=f(t_n,y_n),
$$

$$
k_2=f\left(t_n+\frac{h}{2},y_n+\frac{h}{2}k_1\right),
$$

$$
y_{n+1}=y_n+h k_2.
$$

### Geometric meaning

The method first predicts a midpoint state using the initial slope, then uses the vector field at that midpoint as the average slope over the whole interval. It is the ODE analogue of midpoint quadrature applied to

$$
y(t_{n+1})=y(t_n)+\int_{t_n}^{t_{n+1}}f(t,y(t))\,dt.
$$

### Order

The method matches the Taylor expansion of the exact solution through the $h^2$ terms:

$$
y(t_n+h)=y(t_n)+h f_n+\frac{h^2}{2}(f_t+f_yf)_n+O(h^3).
$$

Therefore

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

### Stability

For $y'=\lambda y$,

$$
R(z)=1+z+\frac{z^2}{2}.
$$

The stability region is larger than Forward Euler's region but still bounded, so stiffness still forces small step sizes.

### Pseudocode

```text
for each step:
    compute the starting slope
    estimate a midpoint state
    evaluate the slope at that midpoint
    advance using the midpoint slope
```

## Historical background

The explicit midpoint rule is one of the simplest second-order Runge-Kutta methods and is historically tied to quadrature-inspired one-step integration formulas.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Explicit Runge-Kutta method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff problems where a low-cost second-order method is sufficient

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
