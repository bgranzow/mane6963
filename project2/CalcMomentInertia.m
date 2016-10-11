  function [Iyy] = CalcMomentInertia(rin, rout)
% function [Iyy] = CalcMomentInertia(rin, rout)
% Brief: Compute the second moment of inertia for an annulus
% Inputs:
%   rin - [Nx,1] vector of inner radius values
%   rout - [Nx,1] vector of outer radius values
% Output:
%   Iyy - [Nx,1] vector of second moments of inertia.

% validate the inputs
assert(iscolumn(rin));
assert(iscolumn(rout));
assert(length(rin) == length(rout));

% compute the second moment of inertia
Iyy = (pi/4.0).*(rout.^4-rin.^4);

end