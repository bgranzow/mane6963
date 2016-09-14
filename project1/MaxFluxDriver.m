L = 0.05;
hmin = 0.01;
hmax = 0.05;

Nx = 100;
Ny = 100;
Np = 6;

Tbot = 363.15;
Ttop = 293.15;
kappa = 20.0;

x = transpose(linspace(0,L,Nx+1));
p0 = 0.01*ones(Np,1);
[A,b] = Constraints(L,x,p0,hmin,hmax);

h = @(p) SurfHeight(L,x,p);
f = @(p) -CalcFlux(L,h(p),Nx,Ny,kappa,Ttop,Tbot);

p = fmincon(f, p0, A, b);