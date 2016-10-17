  function [cineq, ceq, dcineq, dceq] = ConstraintStress(p, sigma, Y, h)
% function [cineq, ceq] = ConstraintStress(sigma)
% Brief: Computes nonlinear constraints imposed by the spar normal stress
% Inputs:
%   p - [Np,1] vector of design variables
%   simga - function handle to stress computation
%   Y - scalar, the tensile/compressive yield strength
%   h - scalar, the step size for the complex-step method
% Outputs:
%   cineq - [Nx,1] vector of inequality constraints
%   ceq - an empty array, no nonlinear equality constraints
%   dcineq - [Nx,Np] matrix of inequality constraint derivatives
%   dceq - an empty array, no nonlinear equality derivatives

% validate the inputs
assert(isvector(p));
assert(isscalar(Y));

% enforce the maximal stress inequality constraint
cineq = sigma(p)/Y - 1;
ceq = [];

% compute some needed lengths
Nx = length(cineq);
Np = length(p);
assert(Nx == Np/2);

% compute the constraint Jacobians using complex step
dceq = []; % no equality constraints

dcineq = zeros(Nx,Np);

for k=1:Np
    ek = zeros(Np,1);
    ek(k) = 1.0;
    p_eval = p + 1i*h*ek;
    dc = imag(sigma(p_eval)/Y)/h;
    dcineq(:,k) = dc;
end
dcineq = transpose(dcineq);

end