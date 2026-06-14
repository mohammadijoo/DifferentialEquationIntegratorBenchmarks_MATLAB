function run_one_benchmark(benchmarkName)
%RUN_ONE_BENCHMARK Run one benchmark by registered name.
%
% Example:
%   run_one_benchmark('HarmonicOscillator')
%   run_one_benchmark('RobertsonKinetics')

addpath(genpath(fullfile(pwd, 'src')));

benchmarks = benchmark_registry();
methods = method_registry();
opts = default_options();

idx = find(strcmpi({benchmarks.name}, benchmarkName), 1);
if isempty(idx)
    error('Unknown benchmark "%s". Available names are: %s', ...
        benchmarkName, strjoin({benchmarks.name}, ', '));
end

run_benchmark(benchmarks(idx), methods, opts);
end
