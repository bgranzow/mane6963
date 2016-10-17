% clear any cached variables
clear;

% set up a grid for the analysis
L = 7.5;                % length (m)
Nx = 40;                % number grid points
x = linspace(0,L,Nx);   % computational grid

% set material properties
rho = 1600.0;   % density (kg m^-3)
E = 70e9;       % elastic modulus (kg m^-1 s^-2)
Y = 600e6;      % yield strength (kg m^-1 s^-2)

% compute the loading force
F = (2.5 * 9.8 * 0.5 * 500); % total farce applied to spar
q = CalcForce(F,L,x);        % force per unit area at grid points

% set some constraint parameters
ri_min = 0.01;  % minimum inner radii values (m)
ro_max = 0.05;  % maximum outer radii values (m)
t_min = 0.0025; % annular thickness (m)
lbcon = ConstraintLower(ri_min, t_min, Nx);
[A,b] = ConstraintUpper(ro_max, Nx);

% provide the nominal spar values as initial parameter
r = 0.04635*ones(Nx,1); % nominal values of inner radii
t = 0.00365*ones(Nx,1); % nominal values of annular thickness
p0 = [r;t];             % concactenated design vector

% complex step-method step size
h = 1e-30;

% define anonymous functions to work with
ri      = @(p) p(1:Nx);
ro      = @(p) p(1:Nx) + p(Nx+1:2*Nx);
Iyy     = @(p) CalcMoment(ri(p), ro(p));
u       = @(p) CalcBeamDisplacement(L, E, Iyy(p), q, Nx-1);
sigma   = @(p) CalcBeamStress(L, E, ro(p), u(p), Nx-1);
obj     = @(p) Obj(ri(p), ro(p), rho, L, h);
nlcon   = @(p) ConstraintStress(sigma(p),Y);

% use fmincon to perform gradient based optimization
optns = optimoptions(@fmincon,...
    'Display','iter',...
    'Algorithm', 'sqp',...
    'GradObj', 'on');
p = fmincon(obj,p0,A,b,[],[],lbcon,[],nlcon,optns);

% plot some groovy stuff
Plotter(x,ri(p),ro(p),sigma(p));
