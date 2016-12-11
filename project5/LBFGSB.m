  function [x] = LBFGSB(func,x0,l,u,options)
% function [x] = LBFGSB(func,x0,l,u,options)
% ====
% ====

validate_inputs(func,x0,l,u);
[m,tol,maxiters] = set_options(options);
[x,f,g,n,Y,S,W,M,k,theta] = initialize(func,x0);

while ((get_convergence(x,g,l,u) > tol)&&(k<maxiters))
  x_old = x;
  g_old = g;
  [xc,c] = get_cauchy_point(x,g,l,u,W,M,theta);
  [xmin] = minimize_subspace(x,g,l,u,xc,c,W,M,theta);
  [x,f,g] = line_search(func,x,f,g,xmin-x);
  y = g - g_old;
  s = x - x_old;
  curv = abs(transpose(s)*y);
  if (curv > 1.0e-15*norm(y,2))
    if (k < maxiters)
      Y = [Y zeros(n,1)];
      S = [S zeros(n,1)];
    else
      Y(:,1:m-1) = Y(:,2:end);
      S(:,1:m-1) = S(:,2:end);
    end
  end
  theta = (transpose(y)*y)/(transpose(y)*s);
  k = k+1;
end

end