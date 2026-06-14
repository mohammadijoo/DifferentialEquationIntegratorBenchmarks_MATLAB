# Adding a New Integrator

1. Create a MATLAB file in `src/methods/` with signature:

```matlab
function [t, Y, stats] = my_new_method(problem, opts)
```

2. Use `fixed_step_runner` if the method is a first-order fixed-step method.
3. Use `mechanical_step_runner` if the method needs `problem.mechanical`.
4. Return a standard `stats` structure using `init_stats` or compatible fields.
5. Add the method to `src/config/method_registry.m`.
6. Add a documentation page under `docs/methods/`.
7. Run `tests/test_smoke.m`.

The key design rule is that a method should fail loudly and honestly when it is not applicable or numerically breaks down.
