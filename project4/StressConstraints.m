  function [c,ceq,dcdp,dceqdp] = StressConstraints(p,L,E,Y,q,Nx)
% function [c,ceq,dcdp,dceqdp] = StressConstraints(p,L,E,Y,q,Nx)
% Computes nonlinear stress constraints
% Inputs:
%  p - [2*Nx,1] design vector
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
          ro = p(1:Nx) + p(Nx+1:2*Nx);
          Iyy = (pi/4.0).*(ro.^4-ri.^4);
          u = CalcBeamDisplacement(L,E,Iyy,q,Nx-1);
          sigma = CalcBeamStress(L,E,ro,u,Nx-1);
          c = sigma./Y - 1.0;
      end

end