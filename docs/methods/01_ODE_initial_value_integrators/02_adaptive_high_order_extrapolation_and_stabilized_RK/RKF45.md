# RKF45

## Category

Embedded adaptive Runge-Kutta-Fehlberg method.

## Implemented MATLAB file

```text
src/methods/rkf45.m
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

### Embedded pair

RKF45 computes fourth- and fifth-order approximations from shared Runge-Kutta stages:

$$
y_{n+1}^{[4]}=y_n+h\sum_i b_i^{[4]}k_i,
$$

$$
y_{n+1}^{[5]}=y_n+h\sum_i b_i^{[5]}k_i.
$$

The stages are explicit:

$$
k_i=f\left(t_n+c_i h,y_n+h\sum_{j<i}a_{ij}k_j\right).
$$

### Error estimate

The embedded local error estimate is

$$
e_{n+1}=y_{n+1}^{[5]}-y_{n+1}^{[4]}.
$$

A scaled norm of this difference is compared with the requested tolerance.

### Step-size adaptation

A typical controller uses

$$
h_{\text{new}}=\eta h\left(\frac{\mathrm{tol}}{\|e_{n+1}\|}\right)^{1/(p+1)},
$$

where $\eta$ is a safety factor and $p$ is the order used in the error estimate.

### Geometric meaning

The method tests whether two different high-order models of the same step agree. Agreement means the local curve is well resolved; disagreement means the step is too large.

### Stability

RKF45 is explicit. Adaptive step-size control improves efficiency and accuracy control but does not remove stiffness restrictions.

### Pseudocode

```text
for each attempted step:
    compute shared RK stages
    form fourth- and fifth-order estimates
    estimate error by their difference
    accept or reject the step
    update the next step size
```

## Historical background

Runge-Kutta-Fehlberg formulas introduced embedded pairs that estimate local error by computing two different orders from shared stages.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Embedded adaptive Runge-Kutta-Fehlberg method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

non-stiff problems with changing time scales where adaptive step-size control is useful

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
