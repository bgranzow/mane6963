% clear any cached variables
clear;

% analysis variables
L = 7.5;        % length (m)
Nx = 30;        % number grid points
rho = 1600.0;   % density (kg m^-3)
E = 70e9;       % elastic modulus (kg m^-1 s^-2)
Y = 600e6;      % yield strength (kg m^-1 s^-2)

% compute the loading force
w = (2.5 * 9.8 * 0.5 * 500);                % total farce applied to spar
q = (2.0*w/L)*(1.0-(linspace(0,L,Nx))./L);  % force per unit area

% set some constraint parameters
ri_min = 0.01;  % minimum inner radii values (m)
ro_max = 0.05;  % maximum outer radii values (m)
t_min = 0.0025; % annular thickness (m)

% lower bound constraints
ri_lb = ri_min*ones(Nx,1);  % lower bounds on the inner radii
t_lb = t_min*ones(Nx,1);    % lower bounds for the thickness
lb = [ri_lb; t_lb];         % total lower bound vector

% upper bound constraint
A = zeros(Nx,2*Nx);
for i=1:Nx
    A(i,i) = 1.0;
    A(i,Nx+i) = 1.0;
end
b = ro_max*ones(Nx,1);

% provide the nominal spar values as initial parameter
r = 0.04635*ones(Nx,1); % nominal values of inner radii
t = 0.00365*ones(Nx,1); % nominal values of annular thickness
p0 = [r;t];             % concactenated design vector

% define anonymous functions to work with
f       = @(p) CalcWeight(p,L,rho,Nx);
nlcon   = @(p) StressConstraints(p,L,E,Y,q,Nx);

% use fmincon to perform gradient based optimization
optns = optimoptions(@fmincon,...
    'Display','iter',...
    'Algorithm', 'sqp',...
    'GradObj', 'on',...
    'GradConst', 'on');
p = fmincon(f,p0,A,b,[],[],lb,[],nlcon,optns);

% plot some groovy stuff
x = linspace(0,L,Nx);   % computational grid
Plotter(x,ri(p),ro(p),sigma(p));
