# Constraint error (`constraint_error`)

## Purpose

`constraint_error` measures violation of algebraic, geometric, or DAE constraints.

## Formula

If the solution should satisfy a constraint equation

$$
g(y)=0,
$$

then a common diagnostic is

$$
C_{\max} = \max_i \left\lVert g(y_i) \right\rVert_2.
$$

For a DAE residual $F(t,y,\dot y)=0$, another useful diagnostic is

$$
R_{\max} = \max_i \left\lVert F(t_i,y_i,\dot y_i) \right\rVert_2.
$$

The value stored in the results table as `constraint_error` is usually $C_{\max}$ or $R_{\max}$, depending on the benchmark definition.

## Interpretation

This metric is important for DAE problems, constrained mechanics, circuits, contact problems, projection methods, and geometric integration.
