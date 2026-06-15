# Strang Splitting

## Category

Second-order operator splitting method.

## Implemented MATLAB file

```text
src/methods/strang_splitting.m
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

### Split form

Suppose

$$
y'=A(y)+B(y),
$$

with subflows $\Phi_A^h$ and $\Phi_B^h$.

### Formula

Strang splitting uses

$$
y_{n+1}=\Phi_A^{h/2}\circ\Phi_B^h\circ\Phi_A^{h/2}(y_n).
$$

### Geometric meaning

The method applies half of one subsystem, all of the other subsystem, then the remaining half of the first subsystem. The symmetry cancels the leading first-order splitting error.

### Accuracy

Under smoothness assumptions,

$$
\text{local error}=O(h^3), \qquad \text{global error}=O(h^2).
$$

For linear operators, it approximates

$$
e^{h(A+B)} \approx e^{hA/2}e^{hB}e^{hA/2}.
$$

The leading errors depend on commutators such as $[A,[A,B]]$ and $[B,[A,B]]$.

### Pseudocode

```text
for each step:
    apply subsystem A for half a step
    apply subsystem B for one full step
    apply subsystem A for half a step
```

## Historical background

Strang splitting is a classical symmetric operator splitting method introduced by Gilbert Strang and widely used for decomposed evolution equations.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Second-order operator splitting method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

systems that naturally split into exactly or cheaply solvable subproblems

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
