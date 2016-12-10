  function [f,g] = quadratic(x)
% function [f,g] = quadratic(x)
% ------------------------------------------------------------------------------
% Simple quadratic test function f = x' x;
% Inputs:
%  x - [n,1] Design vector.
% Outputs:
%  f - Objective value at x.
%  g - [n,1] Objective gradient at x.
% ------------------------------------------------------------------------------

f = transpose(x)*x;
if (nargout > 1)
  g = 2.0*x;
end

end

