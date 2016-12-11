  function [alpha_star] = find_alpha(l,u,xc,du,free_vars_idx)
% function [alpha_star] = find_alpha(l,u,xc,du,free_vars_idx)
% ====
% Find alpha star satisfying the equation:
% "A LIMITED MEMORY ALGORITHM FOR BOUND CONSTRAINED OPTIMIZATION".
% Byrd et al. Page 8, Equation (5.8)
% Inputs:
%  l - [n,1] Lower bound constraint vector.
%  u - [n,1] Upper bound constraint vector.
%  xc - [n,1] Generalized Cauchy point.
%  du - [num_free_vars,1] Solution of the unconstrained min. problem.
% Outputs:
% alpha_star - positive scaling parameter.
% ====

alpha_star = 1;
n = length(free_vars_idx);
for i=1:n
  idx = free_vars_idx(i);
  if (du(i) > 0)
    alpha_star = min(alpha_star, (u(idx)-xc(idx))/du(i));
  else
    alpha_star = min(alpha_star, (l(idx)-xc(idx))/du(i));
  end
end

end