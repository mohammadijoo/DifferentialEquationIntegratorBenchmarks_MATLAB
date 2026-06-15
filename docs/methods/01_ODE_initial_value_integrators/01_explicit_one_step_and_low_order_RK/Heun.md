# Heun

## Category

Explicit Runge-Kutta / improved Euler method.

## Implemented MATLAB file

```text
src/methods/heun.m
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

### Predictor-corrector formula

$$
k_1=f(t_n,y_n),
$$

$$
y_{n+1}^{P}=y_n+h k_1,
$$

$$
k_2=f(t_{n+1},y_{n+1}^{P}),
$$

$$
y_{n+1}=y_n+\frac{h}{2}(k_1+k_2).
$$

### Geometric meaning

Heun's method estimates the area under the vector field by averaging a left endpoint slope and an explicitly predicted right endpoint slope. It is an explicit approximation to the trapezoidal rule.

### Accuracy

The average of the two slopes captures the leading curvature correction, giving

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

### Stability

For the scalar test equation,

$$
R(z)=1+z+\frac{z^2}{2}.
$$

Thus Heun improves accuracy over Forward Euler but remains conditionally stable.

### Relation to implicit trapezoidal rule

The implicit trapezoidal rule uses $f(t_{n+1},y_{n+1})$. Heun replaces the unknown future value by $y_{n+1}^{P}$, avoiding a nonlinear solve at the cost of a smaller stability region.

### Pseudocode

```text
for each step:
    compute current slope
    predict endpoint by Forward Euler
    compute slope at predicted endpoint
    average the two slopes
```

## Historical background

Heun's method is commonly known as the improved Euler method or explicit trapezoidal Runge-Kutta method and belongs to the early family of second-order predictor-corrector ideas.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Explicit Runge-Kutta / improved Euler method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff problems where endpoint slope averaging gives good accuracy

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
