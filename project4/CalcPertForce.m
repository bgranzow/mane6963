  function [f] = CalcPertForce(pts,w,L,Nx)
% function [f] = CalcPertForce(pts,w,L,Nx)
% Calculate a pertured force value due to uncertaintity
% Inputs:
%  pts - Evaluation points of the uncertain parameters xi_i
%  w - The loading weight on a single spar
%  L - The length of the spar
%  Nx - The number of x grid points
% Outputs:
%  f - Perturbed force values at grid points

x = linspace(0,L,Nx);
f = (2.0*w/L)*(1.0-x./L);
delta = 0;
for n=1:4
    delta = delta + pts(n)*cos(((2*n-1).*pi.*x)/(2*L));
end
f = f + delta;
end