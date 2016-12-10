  function [P] = do_projection(x,l,u)
% function [P] = do_projection(x,l,u)
% ====
% Project a vector onto the feasible design space.
% "A LIMITED MEMORY ALGORITHM FOR BOUND CONSTRAINED OPTIMIZATION".
% Byrd et al. Page 2, Equation (2.2)
% Inputs:
%  x - [n,1] The vector to project.
%  l - [n,1] The lower bound constraints.
%  u - [n,1] The upper bound constraints.
% Outputs:
%  P - [n,1] The projected vector.
% ====

n = length(x);
P = zeros(n,1);
for i=1:n
  if (x(i) < l(i))
    P(i) = l(i);
  elseif (x(i) > u(i))
    P(i) = u(i);
  else
    P(i) = x(i);
  end
end

end

