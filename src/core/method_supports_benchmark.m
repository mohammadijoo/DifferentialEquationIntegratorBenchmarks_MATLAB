function tf = method_supports_benchmark(method, bench)
%METHOD_SUPPORTS_BENCHMARK Check method applicability tags.
if strcmp(method.applicability, 'all_first_order')
    tf = isfield(bench, 'rhs') && isa(bench.rhs, 'function_handle');
elseif strcmp(method.applicability, 'mechanical_separable')
    tf = isfield(bench, 'mechanical') && isfield(bench.mechanical, 'acceleration');
elseif strcmp(method.applicability, 'harmonic_only')
    tf = strcmpi(bench.name, 'HarmonicOscillator');
else
    tf = false;
end
end
