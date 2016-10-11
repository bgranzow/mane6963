  function [w] = CalcWeight(rin,rout,rho,L)
% function [w] = CalcWeight(rin,rout,rho,L)
% Brief: Compute the weight of the spar
% Inputs:
%   rin - [Nx,1] vector of inner radius values
%   rout - [Nx,1] vector of outer radius values
%   rho - scalar value of material density
%   L - spar length
% Outputs:
%   w - scalar value of weight of the spar
% Details:
%   This computes the weight of the spar geometry assuming
%   that the geometry varies linearly between each x-location

% validate the parameters
assert(iscolumn(rin));
assert(iscolumn(rout));
assert(isscalar(rho));
assert(isscalar(L));
assert(length(rin) == length(rout));

% compute the area at each x location
A = pi*(rout.^2-rin.^2);

% integrate the volume of the spar
v = 0.0;
Nx = length(A);
dx = 1.0/(Nx-1.0);
for i=1:Nx-1
    v = v + 0.5*(A(i)+A(i+1))*dx;
end
w = v*rho*9.8;

end
