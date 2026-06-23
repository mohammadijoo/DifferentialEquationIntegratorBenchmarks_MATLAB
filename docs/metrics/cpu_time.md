# Repeated elapsed time (`cpu_time`)

## Purpose

`cpu_time` stores the median elapsed MATLAB execution time for one method on one benchmark after an optional untimed warm-up run.

## Procedure

For $R$ measured repetitions with elapsed times $T_1,\ldots,T_R$,

$$
T_{\mathrm{reported}}=\operatorname{median}(T_1,\ldots,T_R).
$$

The results also include:

- `cpu_time_min`: minimum measured elapsed time,
- `cpu_time_std`: sample standard deviation of the repeated times,
- `timing_repeats`: number of measured repetitions.

The defaults are controlled by `timing_repeats` and `timing_warmup` in `default_options.m`.

## Interpretation

Repeated warmed-up measurements reduce, but do not eliminate, variability from MATLAB JIT compilation, operating-system scheduling, background programs, memory allocation, and hardware state. Timing should therefore be interpreted together with algorithmic work counters such as `nfev`.

The RHS counter is executed in a separate untimed run so its wrapper overhead does not affect `cpu_time`.
