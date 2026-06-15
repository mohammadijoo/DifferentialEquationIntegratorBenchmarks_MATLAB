# Dormand-Prince RK45

## Category

Embedded adaptive Runge-Kutta method.

## Implemented MATLAB file

```text
src/methods/dormand_prince_rk45.m
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

### Embedded 5(4) pair

Dormand-Prince RK45 forms

$$
y_{n+1}^{[5]}=y_n+h\sum_i b_i k_i,
$$

and

$$
y_{n+1}^{[4]}=y_n+h\sum_i \hat b_i k_i.
$$

The difference

$$
e_{n+1}=y_{n+1}^{[5]}-y_{n+1}^{[4]}
$$

estimates local error.

### Stage structure

Each explicit stage has the form

$$
k_i=f\left(t_n+c_i h,y_n+h\sum_{j<i}a_{ij}k_j\right).
$$

### FSAL idea

Many Dormand-Prince implementations use the FSAL property, meaning the final derivative of one accepted step can be reused as the first derivative of the next step. This reduces average function evaluations.

### Adaptive control

A common scaled error is

$$
\mathrm{err}=\left\|\frac{e_{n+1}}{\mathrm{atol}+\mathrm{rtol}\max(|y_n|,|y_{n+1}|)}\right\|.
$$

The step is accepted if $\mathrm{err}\le 1$.

### Stability

Dormand-Prince is excellent for non-stiff problems, but its explicit nature means that stiff equations can produce many rejected steps or very small accepted steps.

### Pseudocode

```text
for each attempted step:
    compute explicit stages
    form fifth- and fourth-order solutions
    estimate scaled error
    accept or reject
    adapt h
```

## Historical background

Dormand-Prince methods are embedded Runge-Kutta pairs designed to optimize the higher-order solution and are the basis of many modern non-stiff adaptive solvers.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Embedded adaptive Runge-Kutta method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

smooth non-stiff problems requiring reliable adaptive error control

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
