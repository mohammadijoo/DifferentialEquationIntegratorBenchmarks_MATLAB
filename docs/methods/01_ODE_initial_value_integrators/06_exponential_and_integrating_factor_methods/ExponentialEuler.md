# Exponential Euler

## Category

Exponential integrator.

## Implemented MATLAB file

```text
src/methods/exponential_euler.m
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

### Semilinear form

Exponential Euler is designed for

$$
y'=Ay+g(t,y),
$$

where $A$ is a known linear operator treated exactly.

### Variation-of-constants formula

The exact solution satisfies

$$
y(t_{n+1})=e^{hA}y(t_n)+\int_0^h e^{(h-s)A}g(t_n+s,y(t_n+s))\,ds.
$$

Freezing the nonlinear term at $(t_n,y_n)$ gives

$$
y_{n+1}=e^{hA}y_n+h\varphi_1(hA)g(t_n,y_n),
$$

where

$$
\varphi_1(z)=\frac{e^z-1}{z}.
$$

### Geometric meaning

The method follows the linear dynamics exactly and approximates only the nonlinear remainder. If the stiffness or fast oscillation is contained in $A$, this can greatly reduce explicit stability restrictions.

### Accuracy

For the full semilinear problem,

$$
\text{local error}=O(h^2), \qquad \text{global error}=O(h).
$$

For the pure linear equation $y'=Ay$, the method is exact.

### Pseudocode

```text
split f into A*y plus g(t,y)
for each step:
    propagate y by e^(hA)
    add h*phi_1(hA)*g(t,y)
```

## Historical background

Exponential integrators developed from the idea of treating the dominant linear part of an ODE exactly using matrix exponentials and related phi-functions.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Exponential integrator family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

semilinear systems where the stiff or oscillatory linear part is known explicitly

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
