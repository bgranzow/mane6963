  function [cineq, ceq] = ConstraintStress(sigma, sigma_max)
% function [cineq, ceq] = ConstraintStress(sigma)
% Brief: Computes nonlinear constraints imposed by the spar normal stress
% Inputs:
%   simga - [Nx,1] vector of normal stresses at grid points
%   sigma_max - scalar, the tensile/compressive yield strength
% Outputs:
%   cineq - [Nx,1] vector of inequality constraints
%   ceq - an empty array, no nonlinear equality constraints

% validate the inputs
assert(isscalar(sigma_max));
assert(isvector(sigma));

% enforce the maximal stress inequality constraint
cineq = sigma/sigma_max - 1;
ceq = [];

end