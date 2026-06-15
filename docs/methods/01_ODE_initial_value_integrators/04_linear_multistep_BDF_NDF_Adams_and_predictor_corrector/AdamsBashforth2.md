# Adams-Bashforth 2

## Category

Explicit two-step Adams-Bashforth method.

## Implemented MATLAB file

```text
src/methods/adams_bashforth2.m
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

With $f_j=f(t_j,y_j)$,

$$
y_{n+1}=y_n+h\left(\frac32 f_n-\frac12 f_{n-1}\right).
$$

The method uses two time levels, so it requires a starting value $y_1$ from another method.

### Geometric meaning

AB2 extrapolates the next interval's slope from the two most recent slopes. It assumes the vector field changes approximately linearly across the step.

### Polynomial derivation

Let $p_1(t)$ be the line interpolating $(t_{n-1},f_{n-1})$ and $(t_n,f_n)$. Then

$$
y_{n+1}=y_n+\int_{t_n}^{t_{n+1}}p_1(t)\,dt,
$$

which gives the coefficients $3/2$ and $-1/2$ for uniform $h$.

### Accuracy and stability

AB2 has

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

It is explicit and has a bounded stability region. The recurrence also contains a parasitic multistep root, so startup quality and step-size selection matter.

### Pseudocode

```text
obtain y0 and y1
store f0 and f1
for each step:
    use the AB2 combination of current and previous slopes
    advance the solution
    shift slope history forward
```

## Historical background

Adams-Bashforth methods are explicit linear multistep formulas based on polynomial extrapolation of the vector field from previous time levels.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Explicit two-step Adams-Bashforth method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff problems where previous slopes can be reused efficiently

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
