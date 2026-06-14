function y = mech_join(q, v)
%MECH_JOIN Join mechanical q and v vectors into y=[q;v].
y = [q(:); v(:)];
end
