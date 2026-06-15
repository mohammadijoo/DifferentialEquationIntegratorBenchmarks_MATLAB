# ABM4 Predictor-Corrector

## Category

Adams-Bashforth-Moulton PECE method.

## Implemented MATLAB file

```text
src/methods/abm4_predictor_corrector.m
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

### PECE structure

ABM4 is often written as Predict-Evaluate-Correct-Evaluate. The predictor is Adams-Bashforth 4:

$$
y_{n+1}^{P}=y_n+\frac{h}{24}(55f_n-59f_{n-1}+37f_{n-2}-9f_{n-3}).
$$

Then compute

$$
f_{n+1}^{P}=f(t_{n+1},y_{n+1}^{P}).
$$

The corrector is the Adams-Moulton 4 formula using the predicted endpoint slope:

$$
y_{n+1}=y_n+\frac{h}{24}(9f_{n+1}^{P}+19f_n-5f_{n-1}+f_{n-2}).
$$

### Geometric meaning

The predictor extrapolates the future behavior from old slopes. The corrector improves that forecast by incorporating an endpoint slope estimate. This is a practical way to get much of the benefit of an implicit corrector without iterating it to convergence.

### Accuracy

With accurate startup values and smooth dynamics,

$$
\text{local error}=O(h^5), \qquad \text{global error}=O(h^4).
$$

### Startup and stability

The method requires multiple previous values and slopes. Since it is still based on explicit prediction and a limited correction, it is efficient for smooth non-stiff problems but not a robust stiff solver.

### Pseudocode

```text
initialize several previous values and slopes
for each step:
    predict endpoint using Adams-Bashforth 4
    evaluate slope at the predicted endpoint
    correct using Adams-Moulton 4
    store the corrected slope for later steps
```

## Historical background

Predictor-corrector Adams methods combine explicit Adams-Bashforth prediction with implicit Adams-Moulton correction.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Adams-Bashforth-Moulton PECE method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff ODEs where multistep efficiency matters

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
