# `max_error`

## Meaning

`max_error` measures the worst trajectory error over the sampled comparison interval.

## Mathematical definition

For sampled times \(t_i\), numerical states \(y_i\), and reference states \(y_{ref}(t_i)\), define

\[
e_i=\|y_i-y_{ref}(t_i)\|_2 .
\]

Then

\[
\texttt{max\_error}=\max_i e_i .
\]

## Interpretation

A smaller value means the method remained close to the reference solution over the whole sampled trajectory. This metric is more conservative than `final_error`.

## Limitations

The value depends on the output sampling grid. If the solver has large internal excursions between output points, `max_error` may not detect them unless dense output or finer sampling is used.
