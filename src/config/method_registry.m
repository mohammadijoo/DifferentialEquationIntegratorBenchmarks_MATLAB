function methods = method_registry()
%METHOD_REGISTRY Return all implemented integrators and their applicability.
%
% tag values:
%   'all_first_order'         any first-order ODE system y'=f(t,y)
%   'stiff_first_order'       first-order method useful for stiff problems
%   'mechanical_separable'    q''=a(q), conservative/separable form
%   'harmonic_only'           special energy-preserving oscillator method
%
% NOTE:
% MATLAB does not reliably allow assigning a populated struct into
% struct([]) with different fields. Therefore the registry is preallocated
% with the exact method-record schema before appending records.

methods = empty_method_array();
methods(end+1) = make_method('ForwardEuler', 'Forward Euler', @forward_euler, 'explicit', 'all_first_order');
methods(end+1) = make_method('ExplicitMidpoint', 'Explicit midpoint RK2', @explicit_midpoint, 'explicit', 'all_first_order');
methods(end+1) = make_method('Heun', 'Heun RK2 / improved Euler', @heun_method, 'explicit', 'all_first_order');
methods(end+1) = make_method('Ralston', 'Ralston RK2', @ralston_method, 'explicit', 'all_first_order');
methods(end+1) = make_method('KuttaRK3', 'Kutta third-order RK', @kutta_rk3, 'runge_kutta', 'all_first_order');
methods(end+1) = make_method('RK4', 'Classical fourth-order RK', @rk4_method, 'runge_kutta', 'all_first_order');
methods(end+1) = make_method('RKF45', 'Runge-Kutta-Fehlberg 4(5)', @rkf45_method, 'adaptive_rk', 'all_first_order');
methods(end+1) = make_method('DormandPrinceRK45', 'Dormand-Prince RK45', @dopri45_method, 'adaptive_rk', 'all_first_order');

methods(end+1) = make_method('BackwardEuler', 'Backward Euler', @backward_euler, 'implicit', 'all_first_order');
methods(end+1) = make_method('ImplicitMidpoint', 'Implicit midpoint', @implicit_midpoint, 'implicit', 'all_first_order');
methods(end+1) = make_method('TrapezoidalRule', 'Implicit trapezoidal rule', @trapezoidal_rule, 'implicit', 'all_first_order');
methods(end+1) = make_method('BDF2', 'Backward differentiation formula 2', @bdf2_method, 'implicit_multistep', 'all_first_order');
methods(end+1) = make_method('AdamsBashforth2', 'Adams-Bashforth 2', @adams_bashforth2, 'explicit_multistep', 'all_first_order');
methods(end+1) = make_method('AdamsBashforth4', 'Adams-Bashforth 4', @adams_bashforth4, 'explicit_multistep', 'all_first_order');
methods(end+1) = make_method('AdamsMoulton2', 'Adams-Moulton 2 / trapezoidal', @adams_moulton2, 'implicit_multistep', 'all_first_order');
methods(end+1) = make_method('ABM4PredictorCorrector', 'Adams-Bashforth-Moulton 4', @abm4_predictor_corrector, 'predictor_corrector', 'all_first_order');

methods(end+1) = make_method('RosenbrockEuler', 'Rosenbrock-Euler', @rosenbrock_euler, 'linearly_implicit', 'all_first_order');
methods(end+1) = make_method('ROS2', 'Two-stage Rosenbrock method', @ros2_method, 'linearly_implicit', 'all_first_order');
methods(end+1) = make_method('ExponentialEuler', 'Exponential Rosenbrock-Euler', @exponential_euler, 'exponential', 'all_first_order');

methods(end+1) = make_method('SymplecticEuler', 'Symplectic Euler', @symplectic_euler, 'symplectic', 'mechanical_separable');
methods(end+1) = make_method('Verlet', 'Stormer-Verlet', @stormer_verlet, 'symplectic', 'mechanical_separable');
methods(end+1) = make_method('VelocityVerlet', 'Velocity Verlet', @velocity_verlet, 'symplectic', 'mechanical_separable');
methods(end+1) = make_method('Leapfrog', 'Leapfrog', @leapfrog_method, 'symplectic', 'mechanical_separable');
methods(end+1) = make_method('Yoshida4', 'Yoshida fourth-order symplectic composition', @yoshida4_method, 'symplectic', 'mechanical_separable');
methods(end+1) = make_method('StrangSplitting', 'Strang splitting mechanical', @strang_splitting, 'splitting', 'mechanical_separable');
methods(end+1) = make_method('NewmarkBeta', 'Newmark-beta', @newmark_beta, 'second_order', 'mechanical_separable');
methods(end+1) = make_method('DiscreteGradientOscillator', 'Discrete gradient oscillator', @discrete_gradient_oscillator, 'energy_preserving', 'harmonic_only');
end

function methods = empty_method_array()
template = make_method('', '', [], '', '');
methods = repmat(template, 0, 1);
end

function m = make_method(name, displayName, solver, category, applicability)
m.name = name;
m.displayName = displayName;
m.solver = solver;
m.category = category;
m.applicability = applicability;
m.doc = fullfile('docs', 'methods', [name '.md']);
end
