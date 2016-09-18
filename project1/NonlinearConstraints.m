  function [cineq,ceq] = NonlinearConstraints(L,x,p,hmin,hmax)
% function [cineq,ceq] = NonlinearConstraints(L,x,p,hmin,hmax)
% Brief: Evaluates surface height constraints as a nonlinear constraint.
% Inputs:
%   L - A scalar value corresponding to the length of the domain.
%   x - An [Nx+1,1] column vector of spatial locations.
%   p - An [Np,1] column vector of design parameters.
% Outpus:
%   cineq - A [2(Nx+1),1] column vector of constraints c(p) <= 0.
%   ceq - An empty array (i.e. no equality constraints c(p) = 0).
% Details:
%   This function computes the nonlinear inequality constraints
%   corresponding to: h_{min} <= h(x,p) <= h_{max}

% Validate the inputs
assert(isscalar(L));
assert(iscolumn(x));
assert(iscolumn(p));

% Enforce the minimum inequality constraint.
c1 = hmin - SurfaceHeight(L,x,p);

% Enforce the maximum inequality constraint.
c2 = SurfaceHeight(L,x,p) - hmax;

% Conctatenate the two inequality constraints.
cineq = [c1;c2];

% Return no equality constraints.
ceq = [];

end