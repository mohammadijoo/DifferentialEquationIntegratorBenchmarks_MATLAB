function [q0,v0] = mechanical_initial_state(bench)
q0 = bench.mechanical.q0(:);
v0 = bench.mechanical.v0(:);
end
