function [q, v] = mech_split(problem, y)
%MECH_SPLIT Split state vector y=[q;v].
qDim = problem.mechanical.q_dim;
q = y(1:qDim);
v = y(qDim+1:2*qDim);
end
