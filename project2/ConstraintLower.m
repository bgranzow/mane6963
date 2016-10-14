  function [lb] = ConstraintLower(ri_min, t_min, Nx)
% function [lb] = ConstraintLower(ri_min, t_min, Nx)
% Brief: Compute lower bounds constraints for the spar
% Inputs:
%   ri_min - scalar, inner radii minimum value
%   t_min - scalar, annulus thickness minimum value
%   Nx - scalar, the number of grid points
% Outputs:
%   lb - [2Nx,1] vector of lower bound constraints

% validate the inputs
assert(isscalar(ri_min));
assert(isscalar(t_min));

% compute constraints
ri_lb = 0.01*ones(Nx,1);    % lower bounds on the inner radii
t_lb = 0.0025*ones(Nx,1);   % lower bounds for the thickness
lb = [ri_lb; t_lb];         % total lower bound vector

end

