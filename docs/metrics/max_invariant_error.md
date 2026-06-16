# `max_invariant_error`

## Meaning

`max_invariant_error` measures the maximum drift of a conserved or diagnostic invariant over the sampled trajectory.

## Mathematical definition

For an invariant \(I(y)\), define

\[
\texttt{max\_invariant\_error}=\max_i |I(y_i)-I(y_0)| .
\]

Examples include mechanical energy, angular momentum, mass conservation, or another benchmark-defined conserved quantity.

## Interpretation

A smaller value means the method better preserves the invariant over the sampled time interval. This is especially important for Hamiltonian, conservative-mechanics, orbital, chemical-kinetics, and DAE benchmarks.

## Limitations

Low invariant drift does not guarantee small trajectory error. A method can preserve energy well while accumulating phase error.
