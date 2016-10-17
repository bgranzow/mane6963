  function [f,g] = Obj(ri,ro,rho,L,h)
% function [f,g] = Obj(ro,ri,rho,L,h)
% Brief: Compute the objective function (spar mass)
% Inputs:
%   ri - [Nx,1] vector of inner radii values at grid points
%   ro - [Nx,1] vector of outer radii values at grid points
%   rho - scalar, spar material density
%   L - scalar, length of the spar
%   h - scalar, step size used for complex step
% Outputs:
%   f - scalar, the value of the objective function
%   g - [2Nx,1] gradient vector of objective

% compute the objective function
f = CalcMass(ri,ro,rho,L);

% reconstruct the design vector
Nx = length(ri);
Np = 2*Nx;
p = [ri;ro-ri];

% compute the gradient of the objective function with complex-step
g = zeros(Np,1);
for j=1:Np
    ej = zeros(Np,1);
    ej(j) = 1.0;
    p_eval = p + 1i*h*ej;
    ri_eval = p_eval(1:Nx);
    ro_eval = p_eval(1:Nx) + p_eval(Nx+1:2*Nx);
    g(j) = imag(CalcMass(ri_eval, ro_eval, rho, L))/h;
end

end
