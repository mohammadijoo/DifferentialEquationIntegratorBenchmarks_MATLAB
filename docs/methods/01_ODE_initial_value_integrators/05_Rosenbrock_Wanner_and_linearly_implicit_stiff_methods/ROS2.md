# ROS2

## Category

Second-order Rosenbrock method.

## Implemented MATLAB file

```text
src/methods/ros2.m
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

### General two-stage Rosenbrock form

With

$$
J_n=\frac{\partial f}{\partial y}(t_n,y_n),
$$

a two-stage ROS2 method solves systems involving

$$
I-\gamma hJ_n.
$$

A representative structure is

$$
(I-\gamma hJ_n)k_1=f(t_n,y_n),
$$

$$
(I-\gamma hJ_n)k_2=f(t_n+\alpha h,y_n+a h k_1)+c hJ_nk_1,
$$

$$
y_{n+1}=y_n+h(m_1k_1+m_2k_2).
$$

### Geometric meaning

ROS2 adds a second linearly implicit stage to Rosenbrock Euler. This captures curvature information while retaining linear solves instead of nonlinear implicit solves.

### Accuracy

The coefficients are selected to satisfy second-order Rosenbrock order conditions:

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

### Stiffness handling

The repeated matrix $I-\gamma hJ_n$ damps stiff components and can often be factored once per step and reused across stages.

### Pseudocode

```text
for each step:
    compute f and J
    factor I-gamma*h*J
    solve first stage
    form and solve second stage
    combine stages to obtain y_new
```

## Historical background

ROS2 methods are second-order members of the Rosenbrock family, using multiple linearly implicit stages to improve accuracy while retaining stiff stability.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Second-order Rosenbrock method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

moderately stiff nonlinear systems where second-order linearly implicit integration is useful

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
