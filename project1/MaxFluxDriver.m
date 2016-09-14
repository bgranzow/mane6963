  function MaxFluxDriver(L,Np,Ttop,Tbot,kappa,hmin,hmax)
% function MaxFluxDriver(L,Np,Ttop,Tbot,kappa,hmin,hmax)
% Inputs:
%   L - A scalar value of the length of the domain.
%   Np - The number of design parameters.
%   Ttop - The temperature at the top surface (air).
%   Tbot - The temperature at the bottom surface (water).
%   kappa - The thermal conductivity of the exchanger (steel).
%   hmin - The minimum height of the top parameterized surface.
%   hmax - The maximum height of the top parameterized surface.

% Choose the grid spacing to accurately account for geometry.
Nx = 2*(Np-1)*15;
Ny = 2*(Np-1)*15;
x = linspace(0,L,Nx+1)';

% Choose a random initial guess for the design parameters. 
p0 = rand(Np,1);

% Create anonymous functions for our objective function and constraints.
h = @(p) SurfaceHeight(L,x,p);
f = @(p) 1.0/CalcFlux(L,h(p),Nx,Ny,kappa,Ttop,Tbot);
c = @(p) NonlinearConstraints(L,x,p,hmin,hmax);

% Set options for Matlab's fmincon routine.
optns = optimoptions(@fmincon,...
    'Display','iter',...
    'Algorithm', 'sqp');

% Perform gradient based optimization to parameterize the geometry.
p = fmincon(f, p0, [], [], [], [], [], [], c, optns);

% Plot the results.
figure
plot(x,h(p),'-xk','LineWidth', 2)
set(gca, 'FontSize', 20, 'LineWidth', 2)
title('Upper surface geometry')
xlabel('x');
ylabel('h(x,p)');
pause

% Print a summary of the percentage improvement over the nominal value
computed = 1.0/f(p);
nominal = 6.93069307e+03;
increase = 100*(computed-nominal)/nominal;
fprintf('Np | Computed flux  |  Nominal flux  | percent increase \n')
fprintf('------------------------------------------------\n')
fprintf('%d  | %.8e | %.8e | %.4e \n', Np, computed, nominal, increase)

return

end