  function [infnorm] = get_convergence(x,g,l,u)
% function [infnorm] = get_convergence(x,g,l,u)
% ====
% Determine if the current iteration state has converged.
% Inputs:
%  x - [n,1] Design vector at iteration k.
%  g - [n,1] Objective gradient at iteration k.
%  l - [n,1] Lower bound constraint vector.
%  u - [n,1] Upper bound constraint vector.
% Outputs:
%  infnorm - First order optimality.
% ====

P = do_projection(x-g,l,u);
infnorm = abs(max(P-x));

end

