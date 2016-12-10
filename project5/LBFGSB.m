  function [x] = LBFGSB(func,x0,l,u,options)
% function [x] = LBFGSB(func,x0,l,u,options)
% ====
% ====

validate_inputs(func,x0,l,u);
[m,tol,maxiters] = set_options(options);
[x,f,g,n,Y,S,W,M,k,theta] = initialize(func,x0);

while ((get_convergence(x,g,l,u) > tol)&&(k<maxiters))
  x_old = x;
  f_old = f;
  g_old = g;
  [xc,c] = get_cauchy_point(x,g,l,u,W,M,theta);
  k = k+1;
end

end