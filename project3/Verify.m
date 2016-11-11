% Verify.m
% verification of the analysis model

% nominal values
r1 = 4.3;
r2 = 0.8;
a0 = 0.036;
a1 = 0.058;

% vary the omega parameter
%omega = 6.5*(2.0*pi/60.0);
omega = linspace(0.3,0.8,100);

% final integration time (non-dimensional)
Tf = 1000;
sigma = zeros(length(omega),1);
for i=1:length(omega)
    sigma(i) = Obj(Tf,r1,r2,a0,a1,omega(i));
end

% plot the verification results
plot(omega, -sigma, '-k', 'LineWidth', 3)
set(gca, 'FontSize', 20, 'LineWidth', 2)
title('Standard deviation objective value')
xlabel('\omega (rad s^{-1})')
ylabel('\sigma (d \phi / d \tau)')