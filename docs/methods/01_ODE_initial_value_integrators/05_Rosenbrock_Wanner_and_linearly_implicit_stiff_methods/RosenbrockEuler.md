# Rosenbrock Euler

## Category

Linearly implicit Rosenbrock method.

## Implemented MATLAB file

```text
src/methods/rosenbrock_euler.m
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

Let

$$
J_n=\frac{\partial f}{\partial y}(t_n,y_n).
$$

Rosenbrock Euler solves

$$
(I-hJ_n)k=f(t_n,y_n),
$$

then updates

$$
y_{n+1}=y_n+h k.
$$

### Geometric meaning

The method approximates the effect of a fully implicit step by linearizing the vector field around the current point. It captures stiff linear behavior while avoiding nonlinear iteration.

### Relation to Backward Euler

For $y'=Ay$, the method gives

$$
y_{n+1}=(I-hA)^{-1}y_n,
$$

which is exactly the Backward Euler update for a linear homogeneous system.

### Accuracy and stability

Rosenbrock Euler is first-order accurate:

$$
\text{global error}=O(h).
$$

For $y'=\lambda y$,

$$
R(z)=\frac{1}{1-z},
$$

so it has Backward-Euler-like scalar stability.

### Pseudocode

```text
for each step:
    evaluate f and Jacobian J
    solve (I-h*J)*k=f
    set y_new=y+h*k
```

## Historical background

Rosenbrock methods were developed as linearly implicit alternatives to fully implicit Runge-Kutta methods, replacing nonlinear solves by linear solves involving Jacobians.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Linearly implicit Rosenbrock method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

stiff systems where linearized implicitness is useful and full nonlinear solves are undesirable

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
