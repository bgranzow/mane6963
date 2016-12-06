  function [] = Plotter(x,ri,ro,sigma)
% function [] = Plotter(x,ri,ro,sigma)
% Brief: Plots results from optimal wing spar design
% Inputs:
%   x - [Nx,1] vector of grid points
%   ri - [Nx,1] vector of inner radii values
%   ro - [Nx,1] vector of outer radii values
%   sigma - [Nx,1] vector of normal stress values
% Outputs:
%   none

figure
hold on
plot(x,ri,'r','LineWidth',2)
plot(x,ro,'k','LineWidth',2)
plot(x,-ri,'r','LineWidth',2)
plot(x,-ro,'k','LineWidth',2)
plot(x,zeros(length(x),1),'--')
set(gca, 'FontSize', 20, 'LineWidth', 2)
title('Cross section of spar geometry')
legend('inner radius (m)','outer radius (m)')
xlabel('x (m)')
ylabel('z (m)')
axis([0,8,-.055,.055])

figure
plot(x,sigma,'r','LineWidth',2)
set(gca, 'FontSize', 20, 'LineWidth', 2)
title('Normal stress on spar')
legend('stress (MPa)')
xlabel('x (m)')
ylabel('\sigma (MPa)')


end

