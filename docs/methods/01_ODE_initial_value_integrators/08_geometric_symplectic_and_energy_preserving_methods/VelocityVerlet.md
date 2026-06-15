# Velocity Verlet

## Category

Second-order symplectic method.

## Implemented MATLAB file

```text
src/methods/velocity_verlet.m
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

### Formula

For

$$
\dot q=v, \qquad \dot v=a(q),
$$

velocity Verlet is

$$
q_{n+1}=q_n+h v_n+\frac{h^2}{2}a(q_n),
$$

$$
v_{n+1}=v_n+\frac{h}{2}\left[a(q_n)+a(q_{n+1})\right].
$$

### Geometric meaning

The position is advanced using current velocity and acceleration. The velocity is then corrected using the average of old and new accelerations. This gives integer-time positions and velocities while retaining leapfrog-like structure.

### Accuracy and symplecticity

Velocity Verlet is second-order:

$$
\text{global error}=O(h^2).
$$

For separable Hamiltonian systems it is symplectic and usually gives bounded long-time energy error.

### Pseudocode

```text
for each step:
    compute current acceleration
    update position
    compute new acceleration
    update velocity using average acceleration
```

## Historical background

Velocity Verlet is a popular reformulation of Verlet integration that updates both positions and velocities explicitly and is widely used in molecular dynamics and mechanics.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Second-order symplectic method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

mechanical systems where both position and velocity outputs are needed

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
