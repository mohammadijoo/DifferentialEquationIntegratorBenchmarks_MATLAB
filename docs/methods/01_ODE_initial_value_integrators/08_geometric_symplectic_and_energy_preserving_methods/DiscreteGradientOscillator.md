# Discrete Gradient Oscillator

## Category

Energy-preserving geometric method.

## Implemented MATLAB file

```text
src/methods/discrete_gradient_oscillator.m
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

### Energy system form

For

$$
\dot y=S\nabla H(y), \qquad S^T=-S,
$$

the exact energy satisfies

$$
\frac{dH}{dt}=\nabla H(y)^TS\nabla H(y)=0.
$$

### Discrete gradient property

A discrete gradient satisfies

$$
H(y_{n+1})-H(y_n)=\bar\nabla H(y_n,y_{n+1})^T(y_{n+1}-y_n).
$$

### Method

$$
\frac{y_{n+1}-y_n}{h}=S\bar\nabla H(y_n,y_{n+1}).
$$

### Exact energy preservation

Using the update,

$$
H(y_{n+1})-H(y_n)=h\bar\nabla H^TS\bar\nabla H=0,
$$

because $S$ is skew-symmetric. Energy is therefore preserved up to solver tolerance and roundoff.

### Geometric meaning

The method constrains the numerical step to remain on the same discrete energy level. This may be more important than local pointwise accuracy for long-time oscillatory simulations.

### Pseudocode

```text
for each step:
    construct a discrete gradient between old and new states
    solve the implicit discrete-gradient equation
    verify the energy balance
```

## Historical background

Discrete gradient methods belong to energy-preserving geometric integration and are designed to reproduce conservation laws at the discrete level.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Energy-preserving geometric method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

oscillatory or Hamiltonian problems where exact preservation of a discrete energy is the main objective

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
