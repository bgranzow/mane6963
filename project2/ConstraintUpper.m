  function [A,b] = ConstraintUpper(ro_max,Nx)
% function [A,b] = ConstraintUpper(ro_max,Nx)
% Brief: Compute linear inequality constraints for the spar
% Inputs:
%   ro_max - scalar, the maximal outer radius value
%   Nx - scalar, the number of grid points
% Outputs:
%   A - [The linear inequality constraint matrix
%   b - The linear inequality constraints

A = zeros(Nx,2*Nx);
for i=1:Nx
    A(i,i) = 1.0;
    A(i,Nx+i) = 1.0;
end
b = ro_max*ones(Nx,1);

end

