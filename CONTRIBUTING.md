# Contributing

Contributions are welcome.

## Good contribution types

- Add a new numerical integrator in `src/methods/`.
- Add a new benchmark equation in `src/benchmarks/`.
- Improve documentation in `docs/`.
- Add validation tests in `tests/`.
- Improve plotting or metrics.

## Method contribution checklist

1. Add a MATLAB function in `src/methods/` with this signature:

   ```matlab
   function [t, Y, stats] = your_method(problem, opts)
   ```

2. Add the method to `src/config/method_registry.m`.
3. Add a documentation file in `docs/methods/YourMethod.md`.
4. Run:

   ```matlab
   tests/test_smoke
   ```

5. If the method is not applicable to all problems, define appropriate tags in the registry.

## Benchmark contribution checklist

1. Add a problem definition in `src/benchmarks/`.
2. Add it to `src/config/benchmark_registry.m`.
3. Include exact solution or a robust reference solver configuration.
4. Add invariant functions if the equation has conserved quantities.
5. Add documentation in `docs/benchmarks/`.

## Numerical integrity expectations

- Do not report a method as successful if it produces NaN/Inf or blows up.
- For implicit methods, expose Newton failure rather than hiding it.
- For chaotic systems, do not overinterpret long-time pointwise error.
- For stiff systems, report solver failure and rejected steps clearly.
