function [instrumented, get_count] = instrument_benchmark_calls(bench)
%INSTRUMENT_BENCHMARK_CALLS Wrap RHS callbacks with a closure-based counter.
% The counter is local to this function and does not use global state.

instrumented = bench;
call_count = 0;
original_rhs = [];
original_acceleration = [];

if isfield(bench, 'rhs') && isa(bench.rhs, 'function_handle')
    original_rhs = bench.rhs;
    instrumented.rhs = @counted_rhs;
end

if isfield(bench, 'mechanical') && isfield(bench.mechanical, 'acceleration') ...
        && isa(bench.mechanical.acceleration, 'function_handle')
    original_acceleration = bench.mechanical.acceleration;
    instrumented.mechanical.acceleration = @counted_acceleration;
end

get_count = @read_count;

    function value = read_count()
        value = call_count;
    end

    function value = counted_rhs(t, y)
        call_count = call_count + 1;
        value = original_rhs(t, y);
    end

    function value = counted_acceleration(t, q)
        call_count = call_count + 1;
        value = original_acceleration(t, q);
    end
end
