# Function evaluations (`nfev`)

## Purpose

`nfev` counts right-hand-side evaluations of the differential equation.

## Formula

If $f(t,y)$ is evaluated $m$ times during one method run, then

$$
N_f = m.
$$

The value stored in the results table as `nfev` is $N_f$.

## Interpretation

This is often a better work metric than timing when comparing algorithms, because timing also depends on language, implementation, machine load, and MATLAB overhead.
