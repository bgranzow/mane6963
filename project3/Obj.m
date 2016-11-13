  function [sigma] = Obj(Tf,r1,r2,a0,a1,omega)
% function [sigma] = Obj(Tf,r1,r2,a0,a1,omega)
% Computes the standard deviation objective function.
% Inputs:
%   Tf - final non-dimensional time.
%   r1 - base platform arm radius.
%   r2 - car platform arm radius.
%   a0 - incline offset.
%   a1 - incline angle
%   omega - radians per second.
% Outputs:
%   sigma - standard deviation of ang. vel. over time.
% Details:
%   The sign of the standard deviation is negated for
%   maximization.

% perform ODE spinup
t_span = [0; 0.1*Tf];
y0 = [0; 0];
func = @(t,y) [ F(t,y(1),y(2),r1,r2,a0,a1,omega); y(1)];
[t, y] = ode45(func, t_span, y0);

% solve the ODE using spinup ICs
t_span = [0; Tf];
y0 = [y(end,1); y(end,2)];
[t, y] = ode45(func, t_span, y0);
y1 = y(:,1);

% compute the standard deviation
ybar = (1.0/Tf)*trapz(t,y1);
squares = (y1-ybar).^2;
integral = trapz(t,squares);
root = sqrt((1.0/Tf)*integral);
sigma = 3*omega*root;
sigma = -sigma;

end
