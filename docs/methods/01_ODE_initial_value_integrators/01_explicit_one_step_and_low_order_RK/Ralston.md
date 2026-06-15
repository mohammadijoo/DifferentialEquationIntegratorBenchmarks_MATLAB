# Ralston

## Category

Explicit second-order Runge-Kutta method.

## Implemented MATLAB file

```text
src/methods/ralston.m
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
k_2=f\left(t_n+\frac{2h}{3},y_n+\frac{2h}{3}k_1\right),
$$

$$
y_{n+1}=y_n+h\left(\frac14 k_1+\frac34 k_2\right).
$$

### Geometric meaning

Ralston's method samples the vector field at the initial point and at a point two-thirds across the interval. The later slope receives larger weight because it better represents the average behavior over the interval.

### Order conditions

A two-stage second-order Runge-Kutta method must satisfy

$$
b_1+b_2=1, \qquad b_2c_2=\frac12.
$$

For Ralston's coefficients,

$$
\frac14+\frac34=1, \qquad \frac34\cdot\frac23=\frac12.
$$

Therefore it is second-order accurate:

$$
\text{global error}=O(h^2).
$$

### Stability

For $y'=\lambda y$,

$$
R(z)=1+z+\frac{z^2}{2}.
$$

The linear scalar stability function is the same as other explicit second-order two-stage RK methods.

### Pseudocode

```text
for each step:
    compute k1
    compute k2 at a two-thirds trial point
    combine k1 and k2 using weights 1/4 and 3/4
```

## Historical background

Ralston's method is a second-order Runge-Kutta formula selected to reduce the local error constant within the two-stage explicit Runge-Kutta family.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Explicit second-order Runge-Kutta method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff problems where a two-stage RK method with a small error constant is desired

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
