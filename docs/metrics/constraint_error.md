# `constraint_error`

## Meaning

`constraint_error` measures violation of algebraic, geometric, or manifold constraints.

## Mathematical definition

For a constraint

\[
g(t,y)=0,
\]

a typical diagnostic is

\[
\texttt{constraint\_error}=\max_i \|g(t_i,y_i)\| .
\]

For DAEs, constrained mechanics, and projection methods, this measures how far the numerical state drifts from the constraint manifold.

## Interpretation

A smaller value means the method respects constraints more accurately. This is central for DAE, constrained-mechanical, circuit, contact, and geometric integration benchmarks.

## Limitations

Constraint error alone does not measure differential-equation residual error, physical energy behavior, or runtime cost.
