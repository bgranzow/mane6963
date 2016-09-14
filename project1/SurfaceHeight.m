  function h = SurfaceHeight(L,x,p)
% function h = SurfaceHeight(L,x,p)
% Brief: Evaluates a surface height for optimal heat exchange.
% Inputs:
%   L - A scalar value corresponding to the length of the domain.
%   x - An [Nx+1,1] column vector of spatial locations.
%   p - An [Np,1] column vector of design parameters.
% Outputs:
%   h - An [Nx+1,1] column vector of height values evaluated at x(i).
% Details:
%   This function returns the surface parameterization given by
%   h(i) = p(1) + sum_{k=1}^{Np} p(k) sin(2 pi (k-1) x(i) / L)

% Validate the inputs.
assert(isscalar(L));
assert(iscolumn(x));
assert(iscolumn(p));

% Get the lengths of the x vector and the parameter vector.
Nx = length(x)-1;
Np = length(p);

% Allocate and initialize the height using the first design parameter.
h = p(1)*ones(Nx+1,1);

% Compute additional parameter contributions to the surface height. 
for k=2:Np
    h = h + p(k).*sin(2.0*pi*(k-1).*x./L).^2;
end

return

end

