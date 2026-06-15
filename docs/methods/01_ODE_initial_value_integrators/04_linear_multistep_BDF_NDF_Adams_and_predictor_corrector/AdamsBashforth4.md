# Adams-Bashforth 4

## Category

Explicit four-step Adams-Bashforth method.

## Implemented MATLAB file

```text
src/methods/adams_bashforth4.m
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
y_{n+1}=y_n+\frac{h}{24}\left(55f_n-59f_{n-1}+37f_{n-2}-9f_{n-3}\right).
$$

The method needs four previous slope values and therefore is not self-starting.

### Geometric meaning

AB4 fits a cubic polynomial through four past slope samples and extrapolates that polynomial over the next interval. More history gives higher order on smooth problems, but also increases sensitivity to rapid changes and startup errors.

### Polynomial derivation

If $p_3(t)$ interpolates

$$
f_n, f_{n-1}, f_{n-2}, f_{n-3},
$$

then

$$
y_{n+1}=y_n+\int_{t_n}^{t_{n+1}}p_3(t)\,dt.
$$

For uniform steps this integral produces the coefficients $55,-59,37,-9$ divided by $24$.

### Accuracy and stability

AB4 has

$$
\text{local error}=O(h^5), \qquad \text{global error}=O(h^4).
$$

Despite its fourth-order accuracy, it is still explicit and has a bounded stability region. Stiff problems may require impractically small steps.

### Pseudocode

```text
generate starting values y0 through y3
store four slope values
for each step:
    apply the AB4 weighted slope extrapolation
    compute the new slope
    update the slope history
```

## Historical background

Higher-order Adams-Bashforth methods extend the same polynomial extrapolation principle to more past vector-field samples.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Explicit four-step Adams-Bashforth method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff problems where long runs benefit from one new function evaluation per step

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
