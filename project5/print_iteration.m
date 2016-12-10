  function [] = print_iteration(f,x,g,l,u,k)
% function [] = print_iteration(f,x,g,l,u,k)
% ====
% Print some useful convergence information at each iteration.
% Inputs:
%  f - Current value of the objective at iteration k.
%  x - [n,1] Current design vector at iteration k.
%  g - [n,1] Objective gradient at iteration k.
%  l - [n,1] Lower bound constraint vector.
%  u - [n,1] Upper bound constraint vector.
%  k - Current iteration number.
% ====

conv = get_convergence(x,g,l,u);
fprintf('%3d %16.8f %16.8f\n',k,f,conv)

end