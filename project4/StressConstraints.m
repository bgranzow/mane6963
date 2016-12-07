  function [c,ceq,dcdp,dceqdp] = StressConstraints(p,pts,wts,w,L,E,Y,Nx)
% function [c,ceq,dcdp,dceqdp] = StressConstraints(p,pts,wts,w,L,E,Y,Nx)
% Computes nonlinear stress constraints
% Inputs:
%  p - [2*Nx,1] design vector
%  pts - [81,4] stochastic collocation integration points
%  wts - [81,1] stochatstic collocation integration weights
%  L - Length of spar domain
%  E - Elastic modulus
%  Y - Yield strength
%  q - force
%  Nx - number or x grid points
% Outputs:
%  c - nonlinear inequality constraints
%  ceq - empty
%  dcdp - jacobian of nonlinear inequality constraints
%  dceqdp - empty

ceq = [];
dceqdp = [];
c = ineq(p);
dcdp = zeros(Nx,2*Nx);
h = 1.0e-30;

for i=1:2*Nx
    pc = p;
    pc(i) = pc(i) + 1i*h;
    dcdp(:,i) = imag(ineq(pc))/h;
end
dcdp = dcdp.';

      function c = ineq(p)
          ri = p(1:Nx);
          ro = ri + p(Nx+1:2*Nx);
          Iyy = (pi/4.0).*(ro.^4-ri.^4);
          [exp, var] = CalcStress(pts,wts,ro,Iyy,w,L,E,Nx);
          std = sqrt(var - exp.*exp);
          c = (exp + 6*std)./Y - 1.0;
      end

end