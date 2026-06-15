# RK4

## Category

Classical explicit fourth-order Runge-Kutta method.

## Implemented MATLAB file

```text
src/methods/rk4.m
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
k_3=f\left(t_n+\frac{h}{2},y_n+\frac{h}{2}k_2\right),
$$

$$
k_4=f(t_n+h,y_n+hk_3),
$$

$$
y_{n+1}=y_n+\frac{h}{6}(k_1+2k_2+2k_3+k_4).
$$

### Geometric meaning

RK4 estimates the average vector field over the interval using slopes at the beginning, two midpoint trial points, and the endpoint. The weights $1,2,2,1$ create a high-order quadrature-like approximation of the integral form of the ODE.

### Accuracy

RK4 satisfies the fourth-order Runge-Kutta order conditions:

$$
\text{local error}=O(h^5), \qquad \text{global error}=O(h^4).
$$

Halving the step size typically reduces global error by about $2^4=16$ on smooth non-stiff problems.

### Stability

For $y'=\lambda y$,

$$
R(z)=1+z+\frac{z^2}{2}+\frac{z^3}{6}+\frac{z^4}{24}.
$$

The stability region is much larger than that of low-order explicit Euler methods, but it is still bounded and not suitable for severe stiffness.

### Long-time mechanics

RK4 is not symplectic. In Hamiltonian systems it can have small short-time error but still accumulate long-time energy drift. Therefore, in Kepler or oscillator tests, RK4 should be compared with symplectic methods using invariant drift as well as trajectory error.

### Pseudocode

```text
for each step:
    compute four staged slopes
    average them with weights 1, 2, 2, 1
    advance by h times the weighted average
```

## Historical background

The classical fourth-order Runge-Kutta method is one of the most widely used fixed-step methods, developed from the work of Runge and Kutta on staged one-step integration.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Classical explicit fourth-order Runge-Kutta method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff systems where high accuracy per fixed step is desired

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
