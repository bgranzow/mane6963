  function [xmin] = minimize_subspace(x,g,l,u,xc,c,W,M,theta)
% function [xmin] = minimize_subspace(x,g,,l,u,xc,c,W,M,theta)
% ====
% Subspace minimization for the quadratic model over free variables.
% "A LIMITED MEMORY ALGORITHM FOR BOUND CONSTRAINED OPTIMIZATION".
% Byrd et al. Page 12, Direct Primal Method.
% Inputs:
%  x - [n,1] The current design vector at iteration k.
%  g - [n,1] The objective gradient at iteration k.
%  l - [n,1] Lower bound constraint vector.
%  u - [n,1] Uppder bound constraint vector.
%  xc - [n,1] The generalized Cauchy point.
%  c - [m,1] Minimization initialization vector.
%  W - [n,m] LBFGS matrix container.
%  M - [n,m] LBFGS matrix container.
%  theta - Positive LBFGS scaling parameter.
% Outputs:
%  xmin - minimization to the problem.
% ====

invtheta = 1.0/theta;
free_vars_idx = [];
for i=1:length(xc)
  if ((xc(i)~=u(i)) && (xc(i)~=l(i)))
    free_vars_idx(end+1,1) = i;
  end
end

num_free_vars = length(free_vars_idx);
WZ = zeros(size(W,2), num_free_vars);
for i=1:num_free_vars
  WZ(:,i) = W(free_vars_idx(i),:);
end

rr = g + theta*(xc-x) - W*(M*c);
r = zeros(num_free_vars, 1);
for i=1:num_free_vars
  r(i) = rr(free_vars_idx(i));
end

v = M*(WZ*r);
N = invtheta*WZ*transpose(WZ);
N = eye(size(N)) - M*N;
v = N\v;
du = -invtheta*r - invtheta^2 * transpose(WZ)*v;
alpha_star = find_alpha(l,u,xc,du,free_vars_idx);
d_star = alpha_star*du;

xmin = xc;
for i=1:num_free_vars
  idx = free_vars_idx(i);
  xmin(idx) = xmin(idx) + d_star(i);
end

end