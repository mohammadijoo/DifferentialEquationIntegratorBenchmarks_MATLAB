# Kutta RK3

## Category

Explicit third-order Runge-Kutta method.

## Implemented MATLAB file

```text
src/methods/kutta_rk3.m
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
k_3=f(t_n+h,y_n-hk_1+2hk_2),
$$

$$
y_{n+1}=y_n+\frac{h}{6}(k_1+4k_2+k_3).
$$

### Geometric meaning

The method samples the beginning, middle, and end of the step. The weighting resembles Simpson-type averaging, with the midpoint slope receiving the largest coefficient.

### Accuracy

The coefficients satisfy the third-order Runge-Kutta order conditions, so

$$
\text{local error}=O(h^4), \qquad \text{global error}=O(h^3).
$$

### Stability

For $y'=\lambda y$,

$$
R(z)=1+z+\frac{z^2}{2}+\frac{z^3}{6}.
$$

This is the cubic Taylor approximation of $e^z$. It improves non-stiff accuracy but does not provide stiff stability.

### Pseudocode

```text
for each step:
    compute beginning slope
    compute midpoint slope
    compute corrected endpoint slope
    combine slopes with weights 1, 4, 1 divided by 6
```

## Historical background

Kutta's third-order method is part of the classical Runge-Kutta family developed around the turn of the twentieth century to obtain higher accuracy from staged slope evaluations.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Explicit third-order Runge-Kutta method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff problems where third-order accuracy is useful at moderate cost

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
