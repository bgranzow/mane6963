% set the number of grid points for the analysis
Nx = 10;

% set material properties
L = 7.5;        % length (m)
rho = 1600.0;   % density (kg m^-3)
E = 70e9;       % elastic modulus (kg m^-1 s^-2)
Y = 600e6;      % yield strength (kg m^-1 s^-2) 

% provide most conservative initial guess within constraints
rin = 0.01*ones(Nx,1);  % the inner radius at grid points
rout = 0.05*ones(Nx,1); % the outer radius at grid points
p = [rin;rout];         % concactenated design vector

% compute the loading force 
F = (2.5*9.8*0.5*500);      % total force applied to spar
q = CalcForce(F,L,Nx);  % force per unit area at grid points

% define anonymous functions to work with
rin =   @(p) p(1:Nx);
rout =  @(p) p(Nx+1:2*Nx);
Iyy =   @(p) CalcMomentInertia(rin(p),rout(p));
u =     @(p) CalcBeamDisplacement(L,E,Iyy(p),q,Nx-1);
sigma = @(p) CalcBeamStress(L,E,rout(p),u(p),Nx-1);

disp = u(p);
disp = disp(1:2:length(disp));
x = linspace(0,L,Nx);
plot(x,sigma(p));
pause

optns = optimoptions(@fmincon,...
    'Display', 'iter', ...
    'Algorithm', 'sqp');