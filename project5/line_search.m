  function [x,f,g] = line_search(func,x0,f0,g0,p)
% function [x,f,g] = line_search(func,x0,f0,g0,p)
% ====
% A simple backtracking line search method.
% See Algorithm 3.1 "Numerical Optimization". Nocedal and Wright.
% Inputs:
%  func - The objective function handle.
%  x0 - [n,1] The initial evaluation point.
%  f0 - The value of the objective at x0.
%  g0 - [n,1] The objective gradient at x0.
%  p - [n,1] The search direction.
% Outputs:
%  x - [n,1] The updated design evaluation point.
%  f - The updated value of the objective at x.
%  g - [n,1] The updated objective gradient at x.
% ====

alpha = 1.0;
c1 = 1.0e-4;
c2 = 0.9;
cache = c1*transpose(g0)*p;
while (func(x0+alpha*p) > f0 + alpha*cache)
  alpha = alpha*c2;
end
x = x0 + alpha*p;
[f,g] = func(x);

end