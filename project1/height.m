  function h = height(x,p,L)
% function h = height(x,p,L)
% Inputs:
%   x - A column vector of discrete x-coordinates, x(i), i=1,2,...,Nx.
%   p - A column vector of design variables, p(k), k=1,2,...,Np.
%   L - A scalar value corresponding the periodicity length. 
% Outputs:
%   h - A column vector of the parameterized height function evaluated at
%       each discrete x(i) location.
% Details:
%   This function returns the parameterized height of the upper surface
%   of a heat exchanger. If length(p) = 1, then this surface will
%   simply be a flat line. As length(p) increases, more modes are added
%   to the surface to allow for more complex geometries. The definition
%   of the geometry parameterization is given by:
%   h = p_1 + sum_{k=1}^{Np} p_k sin(2 pi (k-1)/ L)

% Check that the x,p are column vectors and L is a scalar.
assert(iscolumn(x));
assert(iscolumn(p));
assert(isscalar(L));

% Get the number of spatial points at which to evaluate the height.
Nx = length(x);

% Get the number of design parameters which define the height.
Np = length(p);

% Compute the first parameter contribution to the height, while also
% initializing the data for the height column vector.
h = p(1)*zeros(Nx,1);

% Compute the remaining parameter contributions to the height.
for k=2:Np
    h = h + p(k)*sin(2.0*pi*(k-1.0)*x/L);
end

end