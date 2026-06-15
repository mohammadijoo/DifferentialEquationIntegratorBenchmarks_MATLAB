# Methods documentation catalog

This package reorganizes the uploaded methods documentation into method-family folders.

Existing repository method Markdown files were moved into their related method-family folders without modifying their file content.
Additional candidate-method and solver-internal Markdown files were also moved into related categories.

## Folder structure

| Folder | Meaning | Files | Current repo methods |
|---|---|---:|---:|
| `01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK` | Explicit one-step and low-order Runge-Kutta ODE methods | 6 | 6 |
| `01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK` | Adaptive, high-order, extrapolation, and stabilized explicit ODE methods | 17 | 2 |
| `01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK` | Implicit one-step, collocation, DIRK, SDIRK, and Radau/Lobatto/Gauss methods | 14 | 3 |
| `01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector` | Linear multistep, BDF/NDF, Adams, and predictor-corrector methods | 21 | 5 |
| `01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods` | Rosenbrock-Wanner and linearly implicit stiff ODE methods | 7 | 2 |
| `01_ODE_initial_value_integrators/06_exponential_and_integrating_factor_methods` | Exponential, exponential Rosenbrock, integrating-factor, and Magnus methods | 16 | 1 |
| `01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods` | IMEX, additive, fractional-step, projection, and operator-splitting methods | 17 | 0 |
| `01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods` | Geometric, symplectic, Lie-group, variational, and energy-preserving methods | 21 | 7 |
| `01_ODE_initial_value_integrators/09_second_order_mechanical_and_structural_dynamics_methods` | Second-order mechanical and structural dynamics methods | 11 | 1 |
| `01_ODE_initial_value_integrators/10_adaptivity_events_jacobians_and_mass_matrix_support` | Adaptive solver control, dense output, event handling, Jacobians, and mass matrices | 11 | 0 |
| `01_ODE_initial_value_integrators/11_nonlinear_solvers_for_implicit_methods` | Nonlinear solvers used inside implicit methods | 12 | 0 |
| `01_ODE_initial_value_integrators/12_linear_algebra_backsolves_and_preconditioners` | Linear algebra, backsolves, matrix factorizations, Krylov methods, and preconditioners | 20 | 0 |
| `02_DAE_integrators_and_constraint_methods` | DAE integrators, mass-matrix methods, and constraint stabilization | 15 | 0 |
| `03_PDE_time_integration_and_spatial_discretization_methods` | PDE time integration and spatial discretization methods | 32 | 0 |
| `04_stochastic_differential_equation_methods` | Stochastic differential equation and stochastic reaction methods | 13 | 0 |
| `05_delay_differential_equation_methods` | Delay differential equation methods | 7 | 0 |
| `06_fractional_differential_equation_methods` | Fractional differential equation and memory-kernel methods | 7 | 0 |
| `07_boundary_value_problem_methods` | Boundary-value problem and continuation methods | 8 | 0 |
| `08_multirate_and_parallel_in_time_methods` | Multirate and parallel-in-time methods | 10 | 0 |

## Verification summary

- Expected current repository methods: 27.
- Current repository method files found in the uploaded zip: 27.
- Missing expected current repository method files: 0.
- Extra current repository method files: 0.
- Placeholder/candidate markers inside current repository method files: 0.
- Current repository method files missing an implemented MATLAB path: 0.

See `_INTEGRITY_REPORT.md` and `_MANIFEST.csv` for details.
