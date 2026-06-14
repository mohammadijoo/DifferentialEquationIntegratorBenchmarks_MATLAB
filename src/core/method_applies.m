function tf = method_applies(problem, method)
%METHOD_APPLIES Check method applicability tags.

switch method.applicability
    case 'all_first_order'
        tf = true;
    case 'stiff_first_order'
        tf = true;
    case 'mechanical_separable'
        tf = isfield(problem, 'mechanical') && problem.mechanical.is_separable;
    case 'harmonic_only'
        tf = strcmp(problem.name, 'HarmonicOscillator');
    otherwise
        tf = false;
end
end
