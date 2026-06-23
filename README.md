# Differential Equation Integrator Benchmarks in MATLAB

A MATLAB benchmark framework for studying, implementing, and comparing numerical integration methods for differential equations.

This repository started as an ODE integrator benchmark suite, but it has been reorganized into a broader numerical-solver catalog covering:

- classical and modern ODE initial-value integrators,
- stiff, implicit, multistep, Rosenbrock, exponential, IMEX, splitting, and geometric methods,
- nonlinear solvers and linear algebra machinery used inside implicit methods,
- DAE, PDE, SDE, DDE, fractional, BVP, hybrid, multirate, and parallel-in-time benchmark directions,
- MATLAB implementations and future implementation scaffolds organized by method and benchmark family.

The repository is intended for numerical-analysis education, control engineering, robotics simulation, computational physics, chemical kinetics, and scientific-computing benchmark development.

---

## Current status

The repository contains two related layers:

1. **Runnable MATLAB benchmark framework**  
   Implemented methods and benchmarks can be executed through `run_all.m` and `run_one_benchmark.m`.

2. **Expanded documentation and implementation roadmap**  
   Many additional methods and benchmark problems are documented and organized in category folders. Some of these are planned/scaffolded and are not executed by default until their MATLAB implementations are completed.

By default, the runner excludes planned methods and planned benchmarks. This keeps the repository runnable while the catalog grows.

---

## Quick start

Open MATLAB in the repository root and run:

```matlab
run_all
```

Run a single benchmark by registry name:

```matlab
run_one_benchmark('LinearTestEquation')
run_one_benchmark('LorenzSystem')
run_one_benchmark('RobertsonKinetics')
run_one_benchmark('KeplerTwoBody')
```

Use options explicitly:

```matlab
opts = default_options();
opts.h = 1e-2;
opts.write_plots = true;
opts.write_tables = true;
opts.include_planned_methods = false;
opts.include_planned_benchmarks = false;

results = run_all(opts);
```

Results are written under:

```text
results/
```

or, depending on the benchmark runner, under benchmark-specific result folders such as:

```text
results/<BenchmarkName>/
```

---

## Repository structure

```text
.
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CITATION.cff
├── run_all.m
├── run_one_benchmark.m
├── docs/
│   ├── methods/
│   │   ├── 01_ODE_initial_value_integrators/
│   │   ├── 02_DAE_integrators_and_constraint_methods/
│   │   ├── 03_PDE_time_integration_and_spatial_discretization_methods/
│   │   ├── 04_stochastic_differential_equation_methods/
│   │   ├── 05_delay_differential_equation_methods/
│   │   ├── 06_fractional_differential_equation_methods/
│   │   ├── 07_boundary_value_problem_methods/
│   │   └── 08_multirate_and_parallel_in_time_methods/
│   ├── benchmarks/
│   │   ├── 01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/
│   │   ├── 02_ODE_stiff_multiscale_and_chemical_kinetics/
│   │   ├── 03_Hamiltonian_geometric_and_long_time_mechanics/
│   │   ├── 04_DAE_constrained_systems_and_circuits/
│   │   ├── 05_PDE_method_of_lines_and_conservation_laws/
│   │   ├── 06_SDE_stochastic_differential_equations/
│   │   ├── 07_DDE_delay_differential_equations/
│   │   └── 08_Fractional_BVP_hybrid_and_event_driven_systems/
│   ├── metrics/
│   │   ├── README.md
│   │   ├── final_error.md
│   │   ├── max_error.md
│   │   ├── rmse_error.md
│   │   ├── cpu_time.md
│   │   ├── n_steps.md
│   │   ├── nfev.md
│   │   ├── n_rejected.md
│   │   ├── n_jacobian.md
│   │   ├── n_newton.md
│   │   ├── n_linear_solve.md
│   │   ├── max_invariant_error.md
│   │   ├── positivity_violation.md
│   │   ├── constraint_error.md
│   │   └── status.md
│   ├── tutorials/
│   └── references.md
├── src/
│   ├── config/
│   │   ├── default_options.m
│   │   ├── method_registry.m
│   │   └── benchmark_registry.m
│   ├── core/
│   │   ├── run_benchmark.m
│   │   ├── compute_metrics.m
│   │   ├── newton_solve.m
│   │   └── other shared execution utilities
│   ├── methods/
│   │   ├── 01_ODE_initial_value_integrators/
│   │   ├── 02_DAE_integrators_and_constraint_methods/
│   │   ├── 03_PDE_time_integration_and_spatial_discretization_methods/
│   │   ├── 04_stochastic_differential_equation_methods/
│   │   ├── 05_delay_differential_equation_methods/
│   │   ├── 06_fractional_differential_equation_methods/
│   │   ├── 07_boundary_value_problem_methods/
│   │   └── 08_multirate_and_parallel_in_time_methods/
│   ├── benchmarks/
│   │   ├── 01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/
│   │   ├── 02_ODE_stiff_multiscale_and_chemical_kinetics/
│   │   ├── 03_Hamiltonian_geometric_and_long_time_mechanics/
│   │   ├── 04_DAE_constrained_systems_and_circuits/
│   │   ├── 05_PDE_method_of_lines_and_conservation_laws/
│   │   ├── 06_SDE_stochastic_differential_equations/
│   │   ├── 07_DDE_delay_differential_equations/
│   │   └── 08_Fractional_BVP_hybrid_and_event_driven_systems/
│   └── plotting/
├── tests/
│   └── test_smoke.m
└── results/
```

The `docs/` and `src/` folders intentionally mirror each other: method documentation categories correspond to method implementation categories, benchmark documentation categories correspond to benchmark implementation categories, and metric documentation explains the quantities reported by the framework.

---

## Method documentation categories

The methods catalog is organized by numerical method family, not by implementation status. The left column uses human-readable category names, while the right column links directly to the available Markdown documentation files.

<table>
  <colgroup>
    <col width="30%">
    <col width="70%">
  </colgroup>
  <thead>
    <tr>
      <th>Category</th>
      <th>Method / Documentation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ODE initial value integrators</td>
      <td><strong>Explicit one-step and low-order RK:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK/ForwardEuler.md">Forward Euler</a>, <a href="docs/methods/01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK/ExplicitMidpoint.md">Explicit Midpoint</a>, <a href="docs/methods/01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK/Heun.md">Heun</a>, <a href="docs/methods/01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK/Ralston.md">Ralston</a>, <a href="docs/methods/01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK/KuttaRK3.md">Kutta RK3</a>, <a href="docs/methods/01_ODE_initial_value_integrators/01_explicit_one_step_and_low_order_RK/RK4.md">Classical RK4</a><br><strong>Adaptive, high-order, extrapolation, and stabilized RK:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/RKF45.md">RKF45</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/DormandPrinceRK45.md">Dormand-Prince RK45</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/BogackiShampineRK23.md">Bogacki-Shampine RK23</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/CashKarpRK45.md">Cash-Karp RK45</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/DOP853.md">DOP853</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/RKC.md">RKC</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/ROCK.md">ROCK</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/SSPRK.md">SSPRK</a>, <a href="docs/methods/01_ODE_initial_value_integrators/02_adaptive_high_order_extrapolation_and_stabilized_RK/Tsitouras54.md">Tsitouras 5(4)</a><br><strong>Implicit one-step, collocation, and DIRK:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/BackwardEuler.md">Backward Euler</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/ImplicitMidpoint.md">Implicit Midpoint</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/TrapezoidalRule.md">Trapezoidal Rule</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/DIRK.md">DIRK</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/SDIRK.md">SDIRK</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/ESDIRK.md">ESDIRK</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/RadauIIA3.md">Radau IIA 3</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/RadauIIA5.md">Radau IIA 5</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/GaussLegendreIRK2.md">Gauss-Legendre IRK2</a>, <a href="docs/methods/01_ODE_initial_value_integrators/03_implicit_one_step_collocation_and_DIRK/GaussLegendreIRK4.md">Gauss-Legendre IRK4</a><br><strong>Linear multistep, BDF/NDF, Adams, and predictor-corrector:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/AdamsBashforth2.md">Adams-Bashforth 2</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/AdamsBashforth4.md">Adams-Bashforth 4</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/AdamsMoulton2.md">Adams-Moulton 2</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/ABM4PredictorCorrector.md">ABM4 predictor-corrector</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/BDF1.md">BDF1</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/BDF2.md">BDF2</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/BDF3.md">BDF3</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/CVODEAdams.md">CVODE Adams</a>, <a href="docs/methods/01_ODE_initial_value_integrators/04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector/CVODEBDF.md">CVODE BDF</a><br><strong>Rosenbrock-Wanner and linearly implicit stiff methods:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods/RosenbrockEuler.md">Rosenbrock-Euler</a>, <a href="docs/methods/01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods/ROS2.md">ROS2</a>, <a href="docs/methods/01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods/ROS3.md">ROS3</a>, <a href="docs/methods/01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods/ROS4.md">ROS4</a>, <a href="docs/methods/01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods/RODAS3.md">RODAS3</a>, <a href="docs/methods/01_ODE_initial_value_integrators/05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods/RODAS4.md">RODAS4</a><br><strong>Exponential and integrating-factor methods:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/06_exponential_and_integrating_factor_methods/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/06_exponential_and_integrating_factor_methods/ExponentialEuler.md">Exponential Euler</a>, <a href="docs/methods/01_ODE_initial_value_integrators/06_exponential_and_integrating_factor_methods/ExponentialMidpoint.md">Exponential Midpoint</a>, <a href="docs/methods/01_ODE_initial_value_integrators/06_exponential_and_integrating_factor_methods/ETD2.md">ETD2</a>, <a href="docs/methods/01_ODE_initial_value_integrators/06_exponential_and_integrating_factor_methods/ETDRK4.md">ETDRK4</a>, <a href="docs/methods/01_ODE_initial_value_integrators/06_exponential_and_integrating_factor_methods/EPIRK.md">EPIRK</a><br><strong>IMEX, additive, and operator-splitting methods:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods/IMEXEuler.md">IMEX Euler</a>, <a href="docs/methods/01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods/IMEXRungeKutta.md">IMEX Runge-Kutta</a>, <a href="docs/methods/01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods/ARK2.md">ARK2</a>, <a href="docs/methods/01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods/ARK3.md">ARK3</a>, <a href="docs/methods/01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods/ARK4.md">ARK4</a>, <a href="docs/methods/01_ODE_initial_value_integrators/07_IMEX_additive_and_operator_splitting_methods/LieTrotterSplitting.md">Lie-Trotter splitting</a><br><strong>Geometric, symplectic, and energy-preserving methods:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/SymplecticEuler.md">Symplectic Euler</a>, <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/Verlet.md">Verlet</a>, <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/VelocityVerlet.md">Velocity Verlet</a>, <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/Leapfrog.md">Leapfrog</a>, <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/Yoshida4.md">Yoshida 4</a>, <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/StrangSplitting.md">Strang splitting</a>, <a href="docs/methods/01_ODE_initial_value_integrators/08_geometric_symplectic_and_energy_preserving_methods/DiscreteGradientOscillator.md">Discrete Gradient Oscillator</a><br><strong>Second-order mechanical and structural dynamics methods:</strong> <a href="docs/methods/01_ODE_initial_value_integrators/09_second_order_mechanical_and_structural_dynamics_methods/README.md">category README</a>, <a href="docs/methods/01_ODE_initial_value_integrators/09_second_order_mechanical_and_structural_dynamics_methods/NewmarkBeta.md">Newmark-beta</a>, <a href="docs/methods/01_ODE_initial_value_integrators/09_second_order_mechanical_and_structural_dynamics_methods/CentralDifference.md">Central difference</a>, <a href="docs/methods/01_ODE_initial_value_integrators/09_second_order_mechanical_and_structural_dynamics_methods/GeneralizedAlpha.md">Generalized-alpha</a>, <a href="docs/methods/01_ODE_initial_value_integrators/09_second_order_mechanical_and_structural_dynamics_methods/HHTAlpha.md">HHT-alpha</a>, <a href="docs/methods/01_ODE_initial_value_integrators/09_second_order_mechanical_and_structural_dynamics_methods/RungeKuttaNystrom.md">Runge-Kutta-Nyström</a></td>
    </tr>
    <tr>
      <td>DAE integrators and constraint methods</td>
      <td><a href="docs/methods/02_DAE_integrators_and_constraint_methods/README.md">Category README</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/ImplicitEulerDAE.md">Implicit Euler DAE</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/BDFWithMassMatrix.md">BDF with mass matrix</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/DASSL.md">DASSL</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/DASPK.md">DASPK</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/IDAStyleBDF.md">IDA-style BDF</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/SHAKE.md">SHAKE</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/RATTLE.md">RATTLE</a>, <a href="docs/methods/02_DAE_integrators_and_constraint_methods/BaumgarteStabilization.md">Baumgarte stabilization</a>.</td>
    </tr>
    <tr>
      <td>PDE time integration and spatial discretization methods</td>
      <td><a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/README.md">Category README</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/MethodOfLines.md">Method of lines</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/FiniteDifferenceMethod.md">Finite difference method</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/FiniteVolumeMethod.md">Finite volume method</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/FiniteElementMethod.md">Finite element method</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/FourierSpectralMethod.md">Fourier spectral method</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/ADI.md">ADI</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/CrankNicolsonPDE.md">Crank-Nicolson PDE</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/LaxFriedrichs.md">Lax-Friedrichs</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/LaxWendroff.md">Lax-Wendroff</a>, <a href="docs/methods/03_PDE_time_integration_and_spatial_discretization_methods/WENO.md">WENO</a>.</td>
    </tr>
    <tr>
      <td>Stochastic differential equation methods</td>
      <td><a href="docs/methods/04_stochastic_differential_equation_methods/README.md">Category README</a> for SDE and stochastic-reaction method documentation.</td>
    </tr>
    <tr>
      <td>Delay differential equation methods</td>
      <td><a href="docs/methods/05_delay_differential_equation_methods/README.md">Category README</a> for method-of-steps, history interpolation, neutral DDE, and state-dependent-delay documentation.</td>
    </tr>
    <tr>
      <td>Fractional differential equation methods</td>
      <td><a href="docs/methods/06_fractional_differential_equation_methods/README.md">Category README</a> for fractional ODE/PDE, L1, Grünwald-Letnikov, convolution quadrature, and fast-memory documentation.</td>
    </tr>
    <tr>
      <td>Boundary value problem methods</td>
      <td><a href="docs/methods/07_boundary_value_problem_methods/README.md">Category README</a> for shooting, multiple shooting, collocation, finite-difference BVP, continuation, and pseudo-arclength documentation.</td>
    </tr>
    <tr>
      <td>Multirate and parallel-in-time methods</td>
      <td><a href="docs/methods/08_multirate_and_parallel_in_time_methods/README.md">Category README</a> for multirate RK, MRI-GARK, waveform relaxation, Parareal, PFASST, and parallel-in-time documentation.</td>
    </tr>
  </tbody>
</table>

The ODE folder contains additional subfolders for more precise method families:

```text
01_explicit_one_step_and_low_order_RK
02_adaptive_high_order_extrapolation_and_stabilized_RK
03_implicit_one_step_collocation_and_DIRK
04_linear_multistep_BDF_NDF_Adams_and_predictor_corrector
05_Rosenbrock_Wanner_and_linearly_implicit_stiff_methods
06_exponential_and_integrating_factor_methods
07_IMEX_additive_and_operator_splitting_methods
08_geometric_symplectic_and_energy_preserving_methods
09_second_order_mechanical_and_structural_dynamics_methods
10_adaptivity_events_jacobians_and_mass_matrix_support
11_nonlinear_solvers_for_implicit_methods
12_linear_algebra_backsolves_and_preconditioners
```

---

## Benchmark documentation categories

The benchmark catalog is also organized by problem family. The table below uses human-readable category names and links directly to the available benchmark Markdown documentation files.

<table>
  <colgroup>
    <col width="30%">
    <col width="70%">
  </colgroup>
  <thead>
    <tr>
      <th>Category</th>
      <th>Benchmark / Documentation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ODE nonstiff accuracy and nonlinear dynamics</td>
      <td><a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/README.md">Category README</a><br><a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/BrusselatorODE.md">Brusselator reaction oscillator</a>, <a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/DuffingOscillator.md">Duffing oscillator</a>, <a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/ForcedDampedPendulum.md">Forced damped pendulum</a>, <a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/LogisticGrowth.md">Logistic growth</a>, <a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/LotkaVolterraPredatorPrey.md">Lotka-Volterra predator-prey</a>, <a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/RigidBodyEulerEquations.md">Rigid-body Euler equations</a>, <a href="docs/benchmarks/01_ODE_nonstiff_accuracy_and_nonlinear_dynamics/SIR_EpidemicModel.md">SIR epidemic model</a></td>
    </tr>
    <tr>
      <td>ODE stiff multiscale and chemical kinetics</td>
      <td><a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/README.md">Category README</a><br><a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/AkzoNobelChemicalKinetics.md">Akzo-Nobel chemical kinetics</a>, <a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/AllenCahnMOL_StiffODE.md">Allen-Cahn MOL stiff ODE</a>, <a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/HIRESProblem.md">HIRES problem</a>, <a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/OregonatorBelousovZhabotinsky.md">Oregonator / Belousov-Zhabotinsky</a>, <a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/PollutionModelODE.md">Pollution model ODE</a>, <a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/ProtheroRobinsonProblem.md">Prothero-Robinson problem</a>, <a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/RingModulatorCircuitODE.md">Ring modulator circuit ODE</a>, <a href="docs/benchmarks/02_ODE_stiff_multiscale_and_chemical_kinetics/StiffBrusselatorRegime.md">Stiff Brusselator regime</a></td>
    </tr>
    <tr>
      <td>Hamiltonian geometric and long-time mechanics</td>
      <td><a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/README.md">Category README</a><br><a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/ChargedParticleInMagneticField.md">Charged particle in magnetic field</a>, <a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/DoublePendulum.md">Double pendulum</a>, <a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/FPUTLattice.md">FPUT lattice</a>, <a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/HenonHeilesHamiltonian.md">Henon-Heiles Hamiltonian</a>, <a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/NBodyGravitationalProblem.md">N-body gravitational problem</a>, <a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/PlanarRestrictedThreeBodyProblem.md">Planar restricted three-body problem</a>, <a href="docs/benchmarks/03_Hamiltonian_geometric_and_long_time_mechanics/TodaLattice.md">Toda lattice</a></td>
    </tr>
    <tr>
      <td>DAE constrained systems and circuits</td>
      <td><a href="docs/benchmarks/04_DAE_constrained_systems_and_circuits/README.md">Category README</a><br><a href="docs/benchmarks/04_DAE_constrained_systems_and_circuits/ChemicalEquilibriumDAE.md">Chemical equilibrium DAE</a>, <a href="docs/benchmarks/04_DAE_constrained_systems_and_circuits/PendulumDAE_Index1.md">Pendulum DAE, index 1</a>, <a href="docs/benchmarks/04_DAE_constrained_systems_and_circuits/PendulumDAE_Index3.md">Pendulum DAE, index 3</a>, <a href="docs/benchmarks/04_DAE_constrained_systems_and_circuits/RLC_CircuitDAE.md">RLC circuit DAE</a>, <a href="docs/benchmarks/04_DAE_constrained_systems_and_circuits/RobertsonDAE.md">Robertson DAE</a>, <a href="docs/benchmarks/04_DAE_constrained_systems_and_circuits/SliderCrankDAE.md">Slider-crank DAE</a></td>
    </tr>
    <tr>
      <td>PDE method of lines and conservation laws</td>
      <td><a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/README.md">Category README</a><br><a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/AdvectionEquation1D.md">Advection equation 1D</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/CahnHilliardEquation.md">Cahn-Hilliard equation</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/FisherKPPEquation.md">Fisher-KPP equation</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/GrayScottReactionDiffusion.md">Gray-Scott reaction-diffusion</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/HeatEquation1D.md">Heat equation 1D</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/InviscidBurgersEquation.md">Inviscid Burgers equation</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/KortewegDeVriesEquation.md">Korteweg-de Vries equation</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/KuramotoSivashinskyEquation.md">Kuramoto-Sivashinsky equation</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/ViscousBurgersEquation.md">Viscous Burgers equation</a>, <a href="docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/WaveEquation1D.md">Wave equation 1D</a></td>
    </tr>
    <tr>
      <td>SDE stochastic differential equations</td>
      <td><a href="docs/benchmarks/06_SDE_stochastic_differential_equations/README.md">Category README</a><br><a href="docs/benchmarks/06_SDE_stochastic_differential_equations/CoxIngersollRossSDE.md">Cox-Ingersoll-Ross SDE</a>, <a href="docs/benchmarks/06_SDE_stochastic_differential_equations/GeometricBrownianMotionSDE.md">Geometric Brownian motion SDE</a>, <a href="docs/benchmarks/06_SDE_stochastic_differential_equations/LangevinEquation.md">Langevin equation</a>, <a href="docs/benchmarks/06_SDE_stochastic_differential_equations/OrnsteinUhlenbeckSDE.md">Ornstein-Uhlenbeck SDE</a>, <a href="docs/benchmarks/06_SDE_stochastic_differential_equations/StochasticLogisticEquation.md">Stochastic logistic equation</a>, <a href="docs/benchmarks/06_SDE_stochastic_differential_equations/StochasticLotkaVolterraSDE.md">Stochastic Lotka-Volterra SDE</a></td>
    </tr>
    <tr>
      <td>DDE delay differential equations</td>
      <td><a href="docs/benchmarks/07_DDE_delay_differential_equations/README.md">Category README</a><br><a href="docs/benchmarks/07_DDE_delay_differential_equations/DelayedFeedbackControlDDE.md">Delayed feedback control DDE</a>, <a href="docs/benchmarks/07_DDE_delay_differential_equations/DelayedSIRModel.md">Delayed SIR model</a>, <a href="docs/benchmarks/07_DDE_delay_differential_equations/HutchinsonLogisticDDE.md">Hutchinson logistic DDE</a>, <a href="docs/benchmarks/07_DDE_delay_differential_equations/MackeyGlassDDE.md">Mackey-Glass DDE</a></td>
    </tr>
    <tr>
      <td>Fractional BVP hybrid and event-driven systems</td>
      <td><a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/README.md">Category README</a><br><a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/BlasiusBoundaryLayer.md">Blasius boundary layer</a>, <a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/BouncingBallHybridSystem.md">Bouncing ball hybrid system</a>, <a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/BratuBVP.md">Bratu BVP</a>, <a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/ComplementarityContactProblem.md">Complementarity contact problem</a>, <a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/FractionalDiffusionEquation.md">Fractional diffusion equation</a>, <a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/FractionalRelaxationCaputo.md">Fractional relaxation Caputo</a>, <a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/LaneEmdenBVP.md">Lane-Emden BVP</a>, <a href="docs/benchmarks/08_Fractional_BVP_hybrid_and_event_driven_systems/RelayControlHybridSystem.md">Relay control hybrid system</a></td>
    </tr>
  </tbody>
</table>

---

## Implemented versus planned entries

Registry entries distinguish between runnable implementations and planned/scaffolded entries.

- **Implemented** means the MATLAB runner can execute the method or benchmark by default.
- **Planned** means the documentation and file structure exist, but the method or benchmark should not be treated as a validated implementation yet.
- **Solver-internal components** such as Newton iterations, Jacobian strategies, LU factorizations, Krylov methods, and preconditioners are not always time integrators by themselves. They are included because they are essential for serious stiff, implicit, DAE, and PDE solver benchmarking.

To inspect the current registry from MATLAB:

```matlab
methods = method_registry();
benchmarks = benchmark_registry();

implementedMethods = methods([methods.implemented]);
implementedBenchmarks = benchmarks([benchmarks.implemented]);

{implementedMethods.name}'
{implementedBenchmarks.name}'
```

---

## How execution works

`run_all.m` performs the following steps:

1. Loads default options from `default_options.m`.
2. Adds the repository root and subfolders to the MATLAB path.
3. Loads method and benchmark registries.
4. Filters out planned methods and planned benchmarks by default.
5. Runs applicable method/benchmark combinations.
6. Writes tables and plots when enabled.
7. Optionally writes a global summary table.

Default behavior:

```matlab
opts.include_planned_methods = false;
opts.include_planned_benchmarks = false;
```

This protects normal runs from failing on future scaffold files.

---

## Differential equation classes represented

| Type | Example form | Typical benchmark use |
|---|---|---|
| ODE | `y' = f(t,y)` | control, mechanics, circuits, chemical kinetics, chaos |
| Stiff ODE | `y' = f(t,y)` with separated time scales | implicit methods, BDF/NDF, Rosenbrock, Radau, SDIRK |
| Hamiltonian ODE | `q' = ∂H/∂p`, `p' = -∂H/∂q` | symplectic methods, energy drift, long-time orbits |
| DAE | `F(t,y,y') = 0` | constrained mechanics, circuits, process systems |
| PDE after discretization | `u_t = L(u)` or `M y' = f(y)` | method of lines, stiffness, conservation laws |
| SDE | `dX = a(X)dt + b(X)dW` | stochastic stability, weak/strong convergence |
| DDE | `x'(t)=f(t,x(t),x(t-τ))` | delay systems, history interpolation |
| Fractional DE | Caputo or Grünwald-Letnikov derivatives | memory effects and fractional diffusion |
| BVP | `y' = f(x,y)`, boundary constraints | shooting, collocation, continuation |
| Hybrid/event-driven system | continuous flow plus jumps/switching | event detection and discontinuity handling |

---

## Metrics emphasized

The benchmark framework is designed to compare both numerical accuracy and solver mechanics. Each metric below has its own documentation file under [`docs/metrics/`](docs/metrics/).

| Metric | Meaning | Documentation |
|---|---|---|
| `final_error` | Final-time error against exact or high-accuracy reference solution. | [`final_error`](docs/metrics/final_error.md) |
| `max_error` | Maximum trajectory error over the comparison window. | [`max_error`](docs/metrics/max_error.md) |
| `rmse_error` | Root-mean-square trajectory error. | [`rmse_error`](docs/metrics/rmse_error.md) |
| `cpu_time` | MATLAB wall-clock execution time measured around one method/benchmark run. | [`cpu_time`](docs/metrics/cpu_time.md) |
| `n_steps` | Accepted step count or output-step count, depending on the solver interface. | [`n_steps`](docs/metrics/n_steps.md) |
| `nfev` | Number of right-hand-side evaluations. | [`nfev`](docs/metrics/nfev.md) |
| `n_rejected` | Rejected adaptive steps. | [`n_rejected`](docs/metrics/n_rejected.md) |
| `n_jacobian` | Jacobian evaluations. | [`n_jacobian`](docs/metrics/n_jacobian.md) |
| `n_newton` | Newton or nonlinear iterations for implicit methods. | [`n_newton`](docs/metrics/n_newton.md) |
| `n_linear_solve` | Linear solves/backsolves used inside implicit or linearly implicit methods. | [`n_linear_solve`](docs/metrics/n_linear_solve.md) |
| `max_invariant_error` | Maximum drift in mass, energy, angular momentum, or another invariant. | [`max_invariant_error`](docs/metrics/max_invariant_error.md) |
| `positivity_violation` | Violation of nonnegative state constraints, when applicable. | [`positivity_violation`](docs/metrics/positivity_violation.md) |
| `constraint_error` | DAE or geometric constraint residual, when applicable. | [`constraint_error`](docs/metrics/constraint_error.md) |
| `status` | Success, skipped, non-applicable, blow-up, or failure status. | [`status`](docs/metrics/status.md) |

CPU time alone is not enough for solver comparison. For stiff and implicit methods, Jacobian evaluations, Newton iterations, rejected steps, linear solves, and factorization/backsolve counts are often more informative.

---

## Generated plots

Depending on benchmark and method applicability, plotting utilities may generate:

- solution trajectories,
- error versus time,
- final-error bar charts,
- CPU-time bar charts,
- function-evaluation bar charts,
- work-precision diagrams,
- invariant drift plots,
- positivity or constraint-error plots,
- phase portraits,
- state-space projections,
- orbit plots,
- attractor projections.

---

## Interpretation guide

There is no universal best integrator.

A meaningful comparison is problem-dependent:

- Explicit RK methods are often strong for smooth non-stiff ODEs.
- Adaptive RK methods are useful when automatic local-error control is needed.
- BDF/NDF, Radau, SDIRK, and Rosenbrock-type methods are important for stiff systems.
- Symplectic and variational methods are important for long-time Hamiltonian mechanics.
- Exponential and IMEX methods are important for split stiff/nonstiff systems and PDE semi-discretizations.
- DAE methods require constraint-residual and consistent-initialization diagnostics.
- SDE methods require strong/weak convergence and statistical diagnostics, not only deterministic trajectory error.
- PDE benchmarks require attention to both spatial and temporal discretization error.

---

## Adding a new method

To add a method consistently:

1. Add or update the Markdown file under the correct folder in `docs/methods/`.
2. Add the MATLAB implementation under the matching folder in `src/methods/`.
3. Register the method in `src/config/method_registry.m`.
4. Set `implemented = true` only after the method is runnable and tested.
5. Define method applicability clearly, for example:
   - `all_first_order`,
   - `stiff_first_order`,
   - `mechanical_separable`,
   - `dae`,
   - `sde`,
   - `dde`,
   - `pde_mol`.
6. Run smoke tests and at least one representative benchmark.

---

## Adding a new benchmark

To add a benchmark consistently:

1. Add or update the Markdown file under the correct folder in `docs/benchmarks/`.
2. Add the MATLAB benchmark definition under the matching folder in `src/benchmarks/`.
3. Register it in `src/config/benchmark_registry.m`.
4. Define:
   - right-hand side or residual,
   - default initial condition,
   - time interval,
   - parameter regimes,
   - exact/reference solution strategy,
   - invariants or constraints,
   - recommended plots,
   - method applicability.
5. Set `implemented = true` only when the benchmark can run through the framework.

---

## Suggested MATLAB workflow

Run a quick smoke test:

```matlab
runtests('tests')
```

Run all currently implemented combinations:

```matlab
run_all
```

Run with custom options:

```matlab
opts = default_options();
opts.h = 5e-3;
opts.n_output = 2001;
opts.write_plots = true;
opts.write_tables = true;

results = run_one_benchmark('VanDerPolOscillator', opts);
```

Inspect registries:

```matlab
methods = method_registry();
benchmarks = benchmark_registry();

sum([methods.implemented])
sum([benchmarks.implemented])
```

---

## Documentation policy

Each method document should describe:

- category,
- intended MATLAB file,
- mathematical formulation,
- update formula or residual form,
- accuracy/order,
- stability behavior,
- solver requirements,
- strengths and weaknesses,
- best-use cases,
- metrics relevant to the method.

Each benchmark document should describe:

- governing equation,
- initial/boundary conditions,
- exact or reference solution if available,
- stiffness, invariants, constraints, positivity, or qualitative behavior,
- pseudocode for the right-hand side or residual,
- proposed/implemented MATLAB file,
- recommended metrics and plots.

Each metric document should describe:

- what the metric measures,
- the mathematical definition,
- when the metric is meaningful,
- how to interpret good and bad values,
- limitations and common pitfalls.

---

## Simulation video

A simulation video for the repository is available on YouTube:

<a href="https://www.youtube.com/watch?v=lpxKCCUKyiY" target="_blank">
  <img
    src="https://i.ytimg.com/vi/lpxKCCUKyiY/maxresdefault.jpg"
    alt="Differential Equation Integrator Benchmarks in MATLAB"
    style="max-width: 100%; border-radius: 10px; box-shadow: 0 6px 18px rgba(0,0,0,0.18); margin-top: 0.5rem;"
  />
</a>

---

## MATLAB version

The code is written in plain MATLAB style and avoids Simulink dependencies. It should run on recent MATLAB releases. Some plotting details may require minor adjustment on very old MATLAB versions.

---

## License

This project is released under the MIT License. See [`LICENSE`](LICENSE).

---

## Citation

If this repository helps your teaching, benchmarking, or research workflow, please cite it using the metadata in [`CITATION.cff`](CITATION.cff).

---

## Feedback-driven benchmark improvements

The framework includes the following additions based on technical feedback about benchmark design, trajectory-error measurement, timing reliability, and solver-work accounting.

### Large stiff PDE-derived ODE system

A runnable [Swift-Hohenberg equation benchmark](docs/benchmarks/05_PDE_method_of_lines_and_conservation_laws/SwiftHohenbergEquation.md) has been added. It uses:

- the one-dimensional periodic Swift-Hohenberg equation,
- 128 equispaced spatial points,
- Fourier pseudospectral differentiation,
- a fourth-order stiff spatial operator,
- a deterministic multimode initial condition,
- a high-accuracy stiff reference trajectory.

The spatial discretization produces a 128-dimensional stiff ODE system. This complements the existing Korteweg-de Vries and Kuramoto-Sivashinsky cases by testing scalability, spectral spatial discretization, stiffness handling, and nonlinear pattern-forming dynamics.

Run it with:

```matlab
results = run_one_benchmark('SwiftHohenbergEquation');
```

### Trajectory-wide error metrics

Final-time error can be misleading when an inaccurate numerical trajectory eventually approaches the correct equilibrium. The framework therefore reports errors over the full integration interval:

| Metric | Definition and purpose |
|---|---|
| `final_error` | Error at the final reported time. |
| `max_error` | Largest trajectory error over the integration interval. |
| `time_average_error` | Time integral of the pointwise error divided by total integration time. See [`time_average_error.md`](docs/metrics/time_average_error.md). |
| `rmse_error` | Time-weighted RMS trajectory error computed by trapezoidal integration over the actual output times. See [`rmse_error.md`](docs/metrics/rmse_error.md). |

Using time integration rather than an unweighted average prevents adaptive solvers from being favored or penalized merely because their output times are nonuniform.

### Repeated timing with JIT warm-up

A single elapsed-time measurement can vary because of MATLAB JIT compilation, memory allocation, operating-system scheduling, and background applications. Timing now supports:

- an optional untimed warm-up run,
- multiple measured repetitions,
- median elapsed time in `cpu_time`,
- minimum elapsed time in `cpu_time_min`,
- timing variability in `cpu_time_std`,
- the number of repetitions in `timing_repeats`.

Default settings are:

```matlab
opts.timing_warmup = true;
opts.timing_repeats = 3;
```

The median is used as the primary timing statistic because it is less sensitive to occasional operating-system or background-process delays than a single measurement.

### Independent right-hand-side evaluation counting

The framework can independently count calls to the benchmark right-hand side or mechanical acceleration callback. It uses a closure-based wrapper rather than a global variable.

The counting run is performed separately and is not included in the reported elapsed time, so instrumentation overhead does not distort `cpu_time`. Results include:

- `nfev`, the measured number of callback evaluations,
- `nfev_source`, indicating whether the value came from the instrumented wrapper or solver-provided statistics.

The default setting is:

```matlab
opts.count_rhs_evaluations = true;
```

See [`nfev.md`](docs/metrics/nfev.md) and [`cpu_time.md`](docs/metrics/cpu_time.md) for interpretation guidance.

### Updated summary plots

Benchmark summaries can now generate bar charts for:

- final-time error,
- time-averaged trajectory error,
- time-weighted RMS trajectory error,
- maximum trajectory error,
- right-hand-side evaluation count,
- median elapsed time with timing-variability error bars.

### Runtime-cost controls

Warm-up, repeated timing, and the independent counting pass improve measurement quality but require additional solver executions. For a faster exploratory run, use:

```matlab
opts = default_options();
opts.timing_warmup = false;
opts.timing_repeats = 1;
opts.count_rhs_evaluations = false;

results = run_one_benchmark('SwiftHohenbergEquation', opts);
```

For a more stable timing comparison, increase the number of repetitions:

```matlab
opts = default_options();
opts.timing_repeats = 7;

results = run_one_benchmark('LinearTestEquation', opts);
```

### Validation test

The feedback-driven additions are covered by:

```text
tests/test_feedback_improvements.m
```

Run all tests from the repository root with:

```matlab
runtests('tests')
```
