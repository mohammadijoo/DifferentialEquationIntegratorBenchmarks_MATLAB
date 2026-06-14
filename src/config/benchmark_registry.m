function benchmarks = benchmark_registry()
%BENCHMARK_REGISTRY Return all benchmark problem definitions.
% The normalization step ensures that MATLAB can store all problems in one
% struct array even though only some problems have mechanical metadata,
% metric windows, or invariants.

raw = { ...
    benchmark_linear_decay(), ...
    benchmark_harmonic_oscillator(), ...
    benchmark_vanderpol(), ...
    benchmark_lorenz(), ...
    benchmark_robertson(), ...
    benchmark_kepler_two_body() ...
};

template = benchmark_template();
benchmarks = repmat(template, 1, numel(raw));
for i = 1:numel(raw)
    benchmarks(i) = normalize_problem(raw{i}, template);
end
end

function p = benchmark_template()
p.name = '';
p.title = '';
p.f = [];
p.tspan = [];
p.y0 = [];
p.default_h = [];
p.h_max = [];
p.is_stiff = false;
p.exact = [];
p.params = struct();
p.mechanical = struct('is_separable', false, 'q_dim', [], 'v_dim', [], 'accel', []);
p.invariants = [];
p.positivity_indices = [];
p.metric_tspan = [];
end

function p = normalize_problem(raw, template)
p = template;
fields = fieldnames(raw);
for k = 1:numel(fields)
    p.(fields{k}) = raw.(fields{k});
end
if isempty(p.mechanical)
    p.mechanical = template.mechanical;
end
end
