  function [q] = CalcForce(F,L,Nx)
% function [q] = CalcForce(F,L,Nx)
% Compute the force per unit area loading the spar
% Inputs:
%   F - scalar, value of the total force
%   L - scalar, length of the spar
%   Nx - scalar, the number of x
% Outputs:
%   q - [Nx,1] vector of force per unit area values

% validate the inputs
assert(isscalar(F));
assert(isscalar(L));
assert(isscalar(Nx));

% compute the force per unit area
x = linspace(0,L,Nx);
q = (2.0*F/L)*(1.0-x./L);

end