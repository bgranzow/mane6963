  function [f] = Obj(ri,ro,rho,L)
% function [f] = Obj(ro,ri,rho,L)
% Brief: Compute the objective function (spar mass)
% Inputs:
%   ri - [Nx,1] vector of inner radii values at grid points
%   ro - [Nx,1] vector of outer radii values at grid points
%   rho - scalar, spar material density
%   L - scalar, length of the spar
% Outputs:
%   f - scalar, the value of the objective function

% compute the objective function
f = CalcMass(ro,ri,rho,L);

end
