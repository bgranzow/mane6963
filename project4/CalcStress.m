  function [sigma_exp, sigma_var] = CalcStress(pts,wts,ro,Iyy,w,L,E,Nx)
% function [sigma_exp, sigma_var] = CalcStress(pts,wts,ro,Iyy,w,L,E,Nx)
% Compute the expectation of stress and expectation of stress squared.
% Inputs:
%  pts - [81,4] vector of all shifted integration points.
%  wts - [81,1] vector of all shifted integration weights.
%  ro - [Nx,1] vector of outer radius values at grid points.
%  Iyy - [Nx,1] vector of analysis points at grid points.
%  w - Total weight acting on spar.
%  L - Length of the spar.
%  E - Elastic modulus.
%  Nx - Number of x grid points.
% Outputs:
%  sigma_exp - [Nx,1] expected value of stress.
%  sigma_var - [Nx,1] expected value of stress squared.

sigma_exp = 0;
sigma_var = 0;
for n=1:81
    f = CalcPertForce(pts(n,:),w,L,Nx);
    u = CalcBeamDisplacement(L,E,Iyy,f,Nx-1);
    s = CalcBeamStress(L,E,ro,u,Nx-1);
    sigma_exp = sigma_exp + wts(n)*s;
    sigma_var = sigma_var + wts(n)*s.*s;
end

end