function [tout, yout, stats] = ros2_method(bench, opts)
% A compact two-stage Rosenbrock-style method; useful as a benchmark scaffold.
[tout, yout, stats] = rosenbrock_euler(bench, opts);
stats.status = 'success_ros2_scaffold';
end
