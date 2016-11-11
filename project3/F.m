  function [dy1dtau] = F(tau,y1,y2,r1,r2,a0,a1,omega)
% function [dy1dtau] = F(tau,y1,y2,r1,r2,a0,a1,omega)
% ODE function describing tilt-o-whirl behavior.
% Inputs:
%  tau - nondimensional time.
%  y1 - angular velocity d phi / d tau.
%  y2 - angle phi.
%  r1 - base platform beam radius.
%  r2 - car platform arm radius.
%  a0 - incline offset.
%  a1 - incline angle.
%  omega - radians per second.
% Outputs:
%  dy1dtau - ODE function in terms of tau, y1, and y2

% gravitational constant
grav = 9.81;

% constant coefficient, divined from above
Q0 = 20.0;

% coefficients for the ODE function
a = a0 - a1*cos(tau);
b = 3.0*a1*sin(tau);
g = (1.0/(3.0*omega))*sqrt(grav/r2);
e = r1/(9.0*r2);

% the ODE function itself, split into three terms
t1 = -(g/Q0)*y1;
t2 = -(e-g^2*a)*sin(y2);
t3 = -g^2*b*cos(y2);
dy1dtau = t1 + t2 + t3;

end