  function [m] = CalcMass(ri,ro,rho,L)
% function [m] = CalcMass(ri,ro,rho,L)
% Brief: Compute the total mass of annular wing spar
% Inputs:
%   ri - [Nx,1] vector of inner radii values
%   ro - [Nx,1] vector of outer radii values
%   rho - scalar, density of spar material
%   L - scalar, length of the spar
% Outputs:
%   m - scalar, the total mass of the spar

% validate the inputs
assert(isvector(ri));
assert(isvector(ro));
assert(isscalar(rho));
assert(isscalar(L));

% compute the grid spacing
Nx = length(ri);
dx = L/(Nx-1);

% compute the volume as the sum over all domain segments
% assumption: geometry varies piecewise linearly over segments
V = 0.0;
for j=1:Nx-1
    Vi = (pi*dx/3.0)*(ri(j)^2 + ri(j+1)^2 + ri(j)*ri(j+1));
    Vo = (pi*dx/3.0)*(ro(j)^2 + ro(j+1)^2 + ro(j)*ro(j+1));
    V = V + (Vi-Vo);
end
m = rho*V;

end
