# Forward Euler

## Category

Explicit one-step method.

## Implemented MATLAB file

```text
src/methods/forward_euler.m
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

### Update formula

Forward Euler follows the vector field at the current point:

$$
y_{n+1}=y_n+h f(t_n,y_n).
$$

Every quantity on the right-hand side is known before the step is taken, so the method is explicit.

### Geometric meaning

The value $f(t_n,y_n)$ is the tangent direction of the numerical trajectory at the current point. Forward Euler replaces the curved exact solution over $[t_n,t_{n+1}]$ by the tangent-line approximation

$$
y(t_n+h)\approx y(t_n)+h y'(t_n).
$$

This is accurate only when the step is small enough that the vector field does not change much during the interval.

### Taylor derivation and order

The exact solution satisfies

$$
y(t_n+h)=y(t_n)+h y'(t_n)+\frac{h^2}{2}y''(\xi_n), \qquad \xi_n\in(t_n,t_{n+1}).
$$

Substituting $y'(t_n)=f(t_n,y(t_n))$ and discarding the $h^2$ term gives Forward Euler. Hence

$$
\text{local truncation error}=O(h^2), \qquad \text{global error}=O(h).
$$

Forward Euler is therefore first-order accurate.

### Stability

For the test equation $y'=\lambda y$,

$$
y_{n+1}=(1+h\lambda)y_n.
$$

With $z=h\lambda$, the stability function is

$$
R(z)=1+z.
$$

Stability requires $|1+z|<1$. For real negative $\lambda$ this becomes

$$
0<h<\frac{2}{|\lambda|}.
$$

This severe step-size restriction explains its poor behavior on stiff problems.

### Energy behavior

For the harmonic oscillator $\dot{x}=v$, $\dot{v}=-x$,

$$
x_{n+1}=x_n+h v_n, \qquad v_{n+1}=v_n-hx_n.
$$

The exact energy is $E=(x^2+v^2)/2$, but Forward Euler gives

$$
E_{n+1}=(1+h^2)E_n.
$$

So the numerical energy grows at every step. This makes it a useful baseline showing how a cheap method can fail qualitatively.

### Pseudocode

```text
for each step:
    compute current slope f(t_n, y_n)
    set y_{n+1} = y_n + h*f(t_n, y_n)
    set t_{n+1} = t_n + h
```

## Historical background

Leonhard Euler introduced the underlying numerical idea in the eighteenth century; the method is commonly linked to Euler's 1768-1770 work on integral calculus.

The documentation in this repository is intended as a practical engineering summary. For formal historical work, consult the primary references listed in [`../references.md`](../references.md).

## Strengths

- Gives a clear benchmark representative of the Explicit one-step method family.
- Useful for comparing error, runtime, stability, and invariant behavior.
- Easy to inspect because the implementation is intentionally written in readable MATLAB.

## Weaknesses and limitations

- No single integrator is best for all differential equations.
- Fixed-step methods require careful step-size selection.
- Implicit methods require nonlinear or linear solves.
- Symplectic and energy-oriented methods are meaningful mainly for mechanical/Hamiltonian problems.

## Works best for

linear decay with very small step sizes; simple non-stiff problems

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
