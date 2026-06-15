# Yoshida 4

## Category

Fourth-order symplectic composition method.

## Implemented MATLAB file

```text
src/methods/yoshida4.m
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

### Composition formula

Let $S_h$ be a second-order symmetric symplectic method. Yoshida's fourth-order composition is

$$
\Phi_h^{[4]}=S_{w_1h}\circ S_{w_0h}\circ S_{w_1h},
$$

where

$$
w_1=\frac{1}{2-2^{1/3}}, \qquad w_0=-\frac{2^{1/3}}{2-2^{1/3}}.
$$

These coefficients satisfy

$$
2w_1+w_0=1.
$$

### Geometric meaning

The method takes a forward substep, a negative substep, and another forward substep. The special coefficients cancel the leading error terms of the second-order base method.

### Accuracy and symplecticity

If $S_h$ is symmetric and second-order, the composition gives

$$
\text{local error}=O(h^5), \qquad \text{global error}=O(h^4).
$$

Because a composition of symplectic maps is symplectic, Yoshida4 preserves Hamiltonian phase-space structure.

### Negative substep caution

The middle coefficient $w_0$ is negative. This is usually acceptable for reversible Hamiltonian systems but can be unsuitable for dissipative, constrained, or irreversible problems.

### Pseudocode

```text
for each step:
    apply the base symmetric method with step w1*h
    apply the base symmetric method with step w0*h
    apply the base symmetric method with step w1*h
```

## Historical background

Yoshida's fourth-order compositions showed how higher-order symplectic methods can be constructed by composing lower-order symmetric symplectic maps.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Fourth-order symplectic composition method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

Hamiltonian systems where fourth-order accuracy and symplectic long-time behavior are both desired

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
