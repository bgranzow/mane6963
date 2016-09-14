  function [A,b] = Constraints(L,x,p,hmin,hmax)
% function [A,b] = Constraints(p)
% Inputs:
%   L - A scalar value of the length of the periodic domain.
%   x - An [Nx+1,1] column vector of discrete x locations.
%   p - An [Np,1] column vector of design parameters.
%   hmin - A scalar value for the height constraint hmin < h(x,p).
%   hmax - A scalar value for the height constraint h(x,p) < hmax.
% Outputs:
%   A - A [2*(Nx+1), Np] matrix.
%      The input variable to the inequality constraint A*p < b for use
%      in fmincon.
%   b - A [2*(Nx+1), 1] column vector.
%      The input variable to the inequality constraint A*p < b for use
%      in fmincon.
% Details:
%   This imposes constraints for the surface height parameterization:
%   h(x,p) = p_1 + sum_{k=1}^{Np} p_k sin(2 pi (k-1)/ L)
%   such that 1 < h(x,p) < 5.

% Validate the inputs.
assert(isscalar(L));
assert(iscolumn(x));
assert(iscolumn(p));
assert(isscalar(hmin));
assert(isscalar(hmax));

% Get dimensionality information.
Nx = length(x)-1;
Np = length(p);

% Allocate space for the outputs.
A = zeros(2*(Nx+1),Np);
b = zeros(2*(Nx+1),1);

% Fill in the inequality constraints index by index.
for i=1:Nx+1
    
    % The inequality h(x,p) < hmax.
    A(i,1) = 1.0;
    for k=2:Np
        A(i,k) = sin(2*pi*(k-1)*x(i)/L);
    end
    b(i) = hmax;
    
    % The inequality hmin < h(x,p).
    % Implemented such that -h(x,p) < -hmin;
    offset = Nx+1;
    A(i+offset,1) = -1.0;
    for k=2:Np
        A(i+offset,k) = -sin(2*pi*(k-1)*x(i)/L);
    end
    b(i+offset) = -hmin;
end

end