function b = not_implemented_benchmark(name, equationClass)
%NOT_IMPLEMENTED_BENCHMARK Descriptor for planned non-runnable benchmarks.
b = struct();
b.name = name;
b.displayName = name;
b.equationClass = equationClass;
b.implemented = false;
b.tspan = [0 1];
b.y0 = 0;
b.rhs = [];
b.stiff = false;
end
