# `status`

## Meaning

`status` records the execution outcome of a method/benchmark run.

## Typical values

Common status values include:

- `success`: the method completed the run.
- `not_applicable`: the method is not meaningful for the benchmark.
- `method_planned_not_implemented`: the method is documented or registered but not runnable yet.
- `benchmark_planned_not_runnable`: the benchmark is documented or registered but not runnable yet.
- `failure`: the solver call raised an error.
- `blow_up`: the numerical solution became invalid, unbounded, or unusable.

## Interpretation

This field is essential for automated benchmark tables because a missing numeric metric should not be confused with a valid zero or small value.

## Limitations

Status values are implementation conventions. A `success` status means the run completed, not that the numerical result is accurate or physically meaningful.
