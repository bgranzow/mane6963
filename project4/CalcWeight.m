  function [f,g] = CalcWeight(p,L,rho,Nx)
% function [f,g] = CalcWeight(p,L,rho,Nx)
% Compute the weight of an annular spar
% Inputs:
%  p - [2*Nx,1] design vector
%  L - length of domain
%  rho - density of spar material
%  Nx - number of x grid points

f = weight(p);
g = zeros(2*Nx,1);
h = 1.0e-30;

for i=1:2*Nx
    pc = p;
    pc(i) = pc(i) + 1i*h;
    g(i) = imag(weight(pc))/h;
end

      function f = weight(p)
          ri = p(1:Nx);
          ro = ri + p(Nx+1:2*Nx);
          y = ro.^2 - ri.^2;
          f = trapz(y)*pi*rho*L/(Nx-1);
      end
          
end