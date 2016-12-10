  function [m,tol,maxiters] = set_options(options)
% function [m,tol,maxiters] = set_options(options)
% ====
% Set user-definable options for the LBFGSB algorithm.
% Inputs:
%  options - a Matlab struct.
% Outputs:
%  m - The limited memory storage size [default: 10].
%  tol - The convergence tolerance criteria [default: 1e-6].
%  maxiters - The maximum number of quasi-Newton iterations [default: 100].
% ====

m = 10;
tol = 1e-6;
maxiters = 100;
if (isfield(options,'m'))
  m = options.m;
end
if (isfield(options,'tol'))
  tol = options.tol;
end
if (isfield(options,'maxiters'))
  maxiters = options.maxiters;
end

end