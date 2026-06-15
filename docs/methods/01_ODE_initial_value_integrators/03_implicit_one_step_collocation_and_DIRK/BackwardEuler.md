# Backward Euler

## Category

Implicit one-step method.

## Implemented MATLAB file

```text
src/methods/backward_euler.m
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

### Update formula

Backward Euler evaluates the slope at the future point:

$$
y_{n+1}=y_n+h f(t_{n+1},y_{n+1}).
$$

Because $y_{n+1}$ appears inside $f$, the step is implicit. The unknown future state satisfies

$$
G(Y)=Y-y_n-hf(t_{n+1},Y)=0.
$$

### Geometric meaning

Instead of moving forward along the current tangent, Backward Euler asks for a future point whose tangent slope points back to the current value over one time step. This future-slope construction naturally damps rapidly decaying modes.

### Accuracy

Using the backward Taylor expansion,

$$
y(t_n)=y(t_{n+1})-h y'(t_{n+1})+O(h^2),
$$

and rearranging yields the method. Thus

$$
\text{local truncation error}=O(h^2), \qquad \text{global error}=O(h).
$$

### Linear and nonlinear solves

For $y'=Ay+g(t)$,

$$
(I-hA)y_{n+1}=y_n+h g(t_{n+1}).
$$

For nonlinear $f$, Newton iteration uses Jacobian matrices of the form

$$
I-h\frac{\partial f}{\partial y}(t_{n+1},Y^{(k)}).
$$

### Stability

For $y'=\lambda y$,

$$
R(z)=\frac{1}{1-z}, \qquad z=h\lambda.
$$

The method is A-stable because $|R(z)|<1$ for $\operatorname{Re}(z)<0$. It is also strongly damping since

$$
\lim_{z\to -\infty}R(z)=0.
$$

This makes it robust for stiff dissipative equations, but it can overdamp oscillatory dynamics.

### Pseudocode

```text
for each step:
    define residual G(Y)=Y-y_n-h*f(t_{n+1},Y)
    solve G(Y)=0
    accept the solution Y as y_{n+1}
```

## Historical background

Backward Euler is the implicit counterpart of Euler's method and is a classical member of the one-step finite-difference family used extensively for stiff differential equations.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Implicit one-step method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

stiff dissipative systems, decay-dominated dynamics, and problems where numerical damping is acceptable

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
