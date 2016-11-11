  function [f] = OptObj(p, x, y, hyp)
% function [f] = OptOpj(p, hyp)
% Optimization objective function based on surrogate model.
% Inputs:
%  p - [Np,1] design vector.
%  x - [Ns,Np] lhs sample points.
%  y - [Ns,1] sampled objective values.
%  hyp - hyperparameter struct.
% Outputs:
%  f - Objective function evaluation.

% use consistent covariance and likelihood functions.
covfunc = {@covMaterniso, 1};
likfunc = @likGauss;

% evaluate the gaussian process.
[f s2] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, p);

end

