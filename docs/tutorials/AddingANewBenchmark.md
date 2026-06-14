# Adding a New Benchmark Equation

1. Create a new file in `src/benchmarks/`, for example:

```matlab
function problem = benchmark_my_problem()
```

2. Fill the required fields:

```matlab
problem.name = 'MyProblem';
problem.title = 'My benchmark problem';
problem.f = @(t,y) ...;
problem.tspan = [0, 10];
problem.y0 = [...];
problem.default_h = 0.01;
problem.is_stiff = false;
problem.exact = [];
problem.invariants = [];
problem.positivity_indices = [];
```

3. Add it to `src/config/benchmark_registry.m`.
4. Add documentation in `docs/benchmarks/`.
5. Run the benchmark and inspect generated plots.
