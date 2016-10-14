  function [q] = CalcForce(F,L,x)
% function [q] = CalcForce(F,L,x)
% Compute the force per unit area loading the spar
% Inputs:
%   F - scalar, value of the total force
%   L - scalar, length of the spar
%   x - [Nx,1] vector of grid points
% Outputs:
%   q - [Nx,1] vector of force per unit area values

% validate the inputs
assert(isvector(F));
assert(isvector(L));
assert(isvector(x));

% compute the force per unit area
q = (2.0*F/L)*(1.0-x./L);

end