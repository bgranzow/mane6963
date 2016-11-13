% final time
Tf = 2000;

% nominal values
r1 = 4.3;
r2 = 0.8;
a0 = 0.036;
a1 = 0.058;

% vary the omega parameter
omega = linspace(0.3,0.8,100);

% sample the objective function
sigma1 = zeros(length(omega),1);
for i=1:length(omega)
    sigma1(i) = Obj(Tf,r1,r2,a0,a1,omega(i));
end

% sample the surrogate model
sigma2 = zeros(length(omega),1);
for i=1:length(omega)
    sigma2(i) = OptObj([omega(i) r2 a1], x, y, hyp);
end

% plot the verification results
plot(omega, -sigma1, '-k', 'LineWidth', 3)
hold on
plot(omega, -sigma2, '-r', 'LineWidth', 3)
set(gca, 'FontSize', 20, 'LineWidth', 2)
title('Standard deviation objective value')
xlabel('\omega (rad s^{-1})')
ylabel('\sigma (d \phi / d \tau)')
