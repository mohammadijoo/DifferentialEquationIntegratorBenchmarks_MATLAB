# BDF2

## Category

Implicit two-step backward differentiation formula.

## Implemented MATLAB file

```text
src/methods/bdf2.m
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

BDF2 approximates the derivative at the newest time level:

$$
\frac{3y_{n+1}-4y_n+y_{n-1}}{2h}=f(t_{n+1},y_{n+1}).
$$

It is implicit because the right-hand side depends on $y_{n+1}$.

### Geometric meaning

BDF2 fits a quadratic through recent solution values and differentiates that polynomial at the future point. This endpoint-focused derivative approximation is well suited to stiff decay.

### Accuracy

The derivative approximation is second-order accurate, so

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

### Stability

For $y'=\lambda y$ and $z=h\lambda$, substituting $y_n=\xi^n$ gives

$$
(3-2z)\xi^2-4\xi+1=0.
$$

BDF2 is A-stable. It is therefore much more appropriate for stiff systems than explicit multistep methods.

### Startup

BDF2 needs $y_0$ and $y_1$. The first step is usually produced by Backward Euler or another stable one-step method.

### Pseudocode

```text
obtain y0 and y1
for each later step:
    solve (3*Y - 4*y_n + y_{n-1})/(2*h) = f(t_{n+1},Y)
    shift the solution history forward
```

## Historical background

Backward differentiation formulas are classical implicit linear multistep formulas designed for stiff differential equations by differentiating interpolation polynomials at the newest time level.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Implicit two-step backward differentiation formula family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

stiff dissipative systems where second-order accuracy and strong stability are important

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
