  function [t,d,idx] = get_tdidx(x,g,l,u)
% function [t,d,idx] = get_tdidx(x,g,l,u)
% ====
% Get intermediate variables for use in finding the cauchy point.
% Inputs:
%  x - [n,1] Design vector at iteration k.
%  g - [n,1] Objective gradient at iteration k.
%  l - [n,1] Lower bound constraint vector.
%  u - [n,1] Upper bound constraint vector.
% Outputs:
%  t - [n,1] Breakpoints in each coordinate direction.
%  d - [n,1] Search direction.
%  idx - Sorted indices vector.
% ====

n = length(x);
t = zeros(n,1);
d = -g;
for i=1:n
  if (g(i) < 0)
    t(i) = (x(i)-u(i))/g(i);
  elseif (g(i) > 0)
    t(i) = (x(i)-l(i))/g(i);
  else
    t(i) = inf;
  end
  if (t(i) == 0)
    d(i) = 0.0;
  end
end
tuple = [t linspace(1,n,n)'];
tuple = sortrows(tuple);
idx = tuple(:,2);

end

