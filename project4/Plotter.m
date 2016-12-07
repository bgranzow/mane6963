  function [] = Plotter(p,pts,wts,w,L,E,Nx)
% function [] = Plotter(p,pts,wts,Iyy,w,L,E,Nx)
% Brief: Plots data from wing spar parameters.
% Inputs:
%  p - [2*Nx,1] vector of grid points.
%  pts - [81,4] vector of shifted integration points.
%  wts - [Nx,1] vector of shifted integration weights.
%  w - Total weight acting on spar.
%  L - Total length of the domain.
%  E - Elastic modulus for the spar.
%  Nx - number of x grid points 
% Outputs:
%   none

ri = p(1:Nx);
ro = ri + p(Nx+1:2*Nx);
Iyy = (pi/4.0).*(ro.^4-ri.^4);
[exp,var] = CalcStress(pts,wts,ro,Iyy,w,L,E,Nx);
std = sqrt(var - exp.*exp);
x = linspace(0,L,Nx)';

figure
hold on
plot(x,exp,'k','LineWidth',2)
plot(x,exp+6*std,'--+r','LineWidth',2)
plot(x,exp-6*std,'--r','LineWidth',2)
set(gca, 'FontSize', 16, 'LineWidth', 2)
title('Mean stress +- 6 standard deviations')
legend('mean','mean + 6 std','mean - 6 std')
xlabel('x (m)')
ylabel('\sigma (m)')

figure
hold on
plot(x,ri,'r','LineWidth',2)
plot(x,ro,'k','LineWidth',2)
plot(x,-ri,'r','LineWidth',2)
plot(x,-ro,'k','LineWidth',2)
plot(x,zeros(length(x),1),'--')
set(gca, 'FontSize', 16, 'LineWidth', 2)
title('Cross section of spar geometry')
legend('inner radius (m)','outer radius (m)')
xlabel('x (m)')
ylabel('z (m)')
axis([0,8,-.055,.055])

end

