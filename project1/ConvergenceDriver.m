  function f = ConvergenceDriver(n,L,p,kappa,Ttop,Tbot)
% function f = ConvergenceDriver(n,L,p,kappa,Ttop,Tbot)
% Brief: Evaluates the flux on a sequence of finer grids
% Inputs:
%   n - An [Nn,1] column vector of grid spacings
%   L - A scalar value of the length of the domain
%   kappa - A scalar value, the thermal conductivity coefficient
%   Ttop - The temperature at the top surface
%   Tbot - The temperature at the bottom surface
% Outputs:
%   f - The flux evaluated with different grid spacings.

% validate the inputs
assert(iscolumn(n));
assert(isscalar(L));
assert(iscolumn(p));
assert(isscalar(Ttop));
assert(isscalar(Tbot));

% get the number of times to evaluate the flux
Nn = length(n);
f = zeros(Nn,1);

% evaluate the flux at finer and finer grid spacings
for i=1:Nn
    x = linspace(0,L,n(i)+1)';
    h = SurfaceHeight(L,x,p);
    f(i) = CalcFlux(L,h,n(i),n(i),kappa,Ttop,Tbot);
end

% Plot the results.
figure
plot(n,f,'-xk','LineWidth', 2)
set(gca, 'FontSize', 20, 'LineWidth', 2)
title('Computed Flux per Unit Length')
xlabel('Number of finite volumes (Nx = Ny)');
ylabel('f(p)');

 end