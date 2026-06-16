# `n_steps`

## Meaning

`n_steps` records the number of accepted solver steps or output steps, depending on the method interface.

## Mathematical / implementation meaning

For a fixed-step method with grid points \(t_0,t_1,\ldots,t_N\), usually

\[
\texttt{n\_steps}=N .
\]

For adaptive methods, it should represent accepted internal steps when the solver reports that information. If no explicit count is returned, the framework may fall back to the number of output intervals.

## Interpretation

A lower step count can indicate that a method reached the requested interval with larger steps, but this does not automatically mean better efficiency or accuracy.

## Limitations

Step counts are not directly comparable across methods with different per-step cost. A high-order implicit step may cost much more than a low-order explicit step.
