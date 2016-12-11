  function [x,f,g,n,Y,S,W,M,k,theta] = initialize(func,x0)
% function [x,f,g,n,Y,S,W,M,k,theta] = initialize(func,x0)
% ====
% Initialize data for the LBFGS algorithm.
% Inputs:
%  func - Objective function handle.
%  x0 - [n,1] Initial design vector.
% Outputs:
%  x - [n,1] Copy of x0.
%  f - Objective evaluation at x0.
%  g - [n,1] Gradient of objective evaluated at x0.
%  n - Number of design variables.
%  Y - [n,0] Stored iteration pair (grows to [n,m]).
%  S - [n,0] Stored iteration pair (grows to [n,m]).
%  W - [n,0] BFGS approximation matrix (grows to [n,m]).
%  M - [0,0] BFGS approximation matrix (grows, to [m,m]).
%  theta - BFGS positive scaling parameter.
% ====

x = x0;
[f,g] = feval(func,x);
n = length(x);
Y = zeros(n,0);
S = zeros(n,0);
W = zeros(n,1);
M = zeros(1,1);
k = 0;
theta = 1;

end