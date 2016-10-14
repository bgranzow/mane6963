  function [Iyy] = CalcMoment(ri, ro)
% function [Iyy] = CalcMoment(ri, ro)
% Brief: Compute the second moment of inertia for an annulus
% Inputs:
%   ri - [Nx,1] vector of inner radii values
%   ro - [Nx,1] vector of outer radii values
% Output:
%   Iyy - [Nx,1] vector of second moments of inertia

% validate the inputs
assert(isvector(ri));
assert(isvector(ro));
assert(length(ri) == length(ro));

% compute the second moment of inertia
Iyy = (pi/4.0).*(ro.^4-ri.^4);

end