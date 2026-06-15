# Newmark-Beta

## Category

Second-order structural dynamics time integrator.

## Implemented MATLAB file

```text
src/methods/newmark_beta.m
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

### Second-order dynamics

Newmark methods target systems such as

$$
M\ddot q+C\dot q+Kq=r(t).
$$

Let $v=\dot q$ and $a=\ddot q$.

### Newmark formulas

$$
q_{n+1}=q_n+h v_n+h^2\left[\left(\frac12-\beta\right)a_n+\beta a_{n+1}\right],
$$

$$
v_{n+1}=v_n+h\left[(1-\gamma)a_n+\gamma a_{n+1}\right].
$$

### Geometric meaning

The method assumes a controlled model for acceleration variation across the step. The parameters $\beta$ and $\gamma$ determine how much future acceleration influences displacement and velocity.

### Common parameters

The average-acceleration choice is

$$
\gamma=\frac12, \qquad \beta=\frac14.
$$

For linear structural dynamics, this is second-order and unconditionally stable.

### Accuracy and implicitness

For $\gamma=1/2$, Newmark-beta is typically second-order:

$$
\text{global error}=O(h^2).
$$

When $a_{n+1}$ depends on $q_{n+1}$ and $v_{n+1}$, the step requires solving the equation of motion.

### Pseudocode

```text
for each step:
    predict displacement and velocity
    solve for new acceleration or displacement
    correct displacement and velocity
```

## Historical background

The Newmark-beta family is a standard family of time integration methods in structural dynamics for second-order equations of motion.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Second-order structural dynamics time integrator family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

second-order vibration and structural dynamics models with displacement, velocity, and acceleration states

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
