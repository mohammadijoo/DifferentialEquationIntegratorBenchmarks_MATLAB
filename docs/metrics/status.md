# Run status (`status`)

## Purpose

`status` stores the qualitative outcome of one method-benchmark run.

## Typical values

Common status labels include:

- `success`
- `failure`
- `not_applicable`
- `method_planned_not_implemented`
- `benchmark_planned_not_runnable`
- `blow_up`
- `non_converged`

## Interpretation

A numerical result should not be interpreted from error and timing values alone. The `status` field indicates whether the result is meaningful, skipped, failed, or outside the method's intended applicability.

## Example MATLAB filtering

```matlab
valid = strcmp({records.status}, 'success');
records_success = records(valid);
```
