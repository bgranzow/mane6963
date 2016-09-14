  function h = SurfHeight(L,x,p)
% function h = SurfHeight(L,x,p)
% Inputs:
%   L - A scalar value of the length of the periodic domain.
%   x - An [Nx+1,1] column vector of discrete x-location points.
%   p - A column vector of design variables p(k), k = 1,2,...,Np.
% Outputs:
%   h - An [Nx+1,1] column vector of the parameterized surface evaluated
%       at the locations x(i).
% Details:
%   This function returns the parameterized height of the upper surface
%   of a heat exchanger. If length(p) = 1, then this surface will
%   simply be a flat line. As length(p) increases, more modes are added
%   to the surface to allow for more complex geometries. The definition
%   of the geometry parameterization is given by:
%   h = p_1 + sum_{k=1}^{Np} p_k sin(2 pi (k-1)/ L)

% Validate the inputs.
assert(isscalar(L));
assert(iscolumn(x));
assert(iscolumn(p));

% Get the number of cells in the x-direction.
Nx = length(x)-1;

% Get the number of design parameters which define the height.
Np = length(p);

% Compute the first parameter contribution to the height, while also
% initializing the data for the height column vector.
h = p(1)*ones(Nx+1,1);

% Compute the remaining parameter contributions to the height.
for k=2:Np
    h = h + p(k)*sin(2.0*pi*(k-1.0)*x/L);
end

end