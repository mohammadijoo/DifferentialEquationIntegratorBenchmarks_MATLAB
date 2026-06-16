# `cpu_time`

## Meaning

`cpu_time` records the MATLAB wall-clock runtime for one method/benchmark execution.

## Measurement convention

In the benchmark runner, the solver call is wrapped by MATLAB timing commands equivalent to

```matlab
tic;
[tout, yout, stats] = method.solver(bench, opts);
rec.cpu_time = toc;
```

## Interpretation

A smaller value means the method completed the benchmark faster in that MATLAB environment.

## Limitations

Timing depends on hardware, MATLAB version, vectorization, implementation details, warm-up effects, and operating-system load. For solver comparison, use `cpu_time` together with work metrics such as `nfev`, `n_steps`, `n_rejected`, `n_jacobian`, `n_newton`, and `n_linear_solve`.
