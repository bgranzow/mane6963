  function [xc,c] = get_cauchy_point(x,g,l,u,W,M,theta)
% function [xc,c] = get_cauchy_point(x,g,l,u,W,M,theta)
% ====
% Get the generalized Cauchy point.
% "A LIMITED MEMORY ALGORITHM FOR BOUND CONSTRAINED OPTIMIZATION".
% Byrd et al. Page 8, Algorithm CP.
% Inputs:
%  x - [n,1] The design vector at the iteration k.
%  g - [n,1] The objective gradient at the iteration k.
%  W - [n,m] BFGS matrix container.
%  M - [m,m] BFGS matrix container.
%  theta - Positive BFGS scaling parameter.
% ====

% get necessary intermediate variables
[tt,d,idx] = get_tdidx(x,g,l,u);

% perform initialization
n = length(x);
xc = x;
p = transpose(W)*d;
c = zeros(size(M,1),1);
f_prime = -transpose(d)*d;
f_dprime = -theta*f_prime - transpose(p)*M*p;
dt_min = -f_prime/f_dprime;
t_old = 0;
for j=1:n
  i=j;
  if (tt(idx(j))~=0)
    break;
  end
end
b = idx(i);
t = tt(b);
dt = t - t_old;

%{
% examine subsequent segments
while ((dt_min > dt)&&(i<n))
  if (d(b) > 0)
    xc(b) = ub(b);
  elseif (d(b) < 0)
    xc(b) = lb(b);
  end
  zb = xc(b) - x(b);
  c = c + dt*p;
  WbT = W(1,:);
  f_prime = f_prime + dt*f_dprime + g(b)*g(b) + theta*g(b)*zb - ...
    g(b)*WbT*(M*c);
  f_dprime = f_dprime - theta*g(b)*g(b) - 2.0*(g(b)*transpose(WbT)*(M*p)) - ...
    g(b)*g(b)*WbT*(M*WbT);
  p = p + g(b)*WbT;
  d(b) = 0.0;
  dt_min = -f_prime / f_dprime;
  t_old = t;
  i = i+1;
  if (i < n)
    b = idx(i);
    t = tt(b);
    dt = t - t_old;
  end
end
%}

% updates
dt_min = max(dt_min,0);
t_old = t_old + dt_min;
for i=1:n
  xc(idx(i)) = x(idx(i)) + t_old*d(idx(i));
end
c = c + dt_min*p;

end

