% fixed input values
Tf = 2000;                  % final nondimensional integration time.
a0 = 0.036;                 % incline offset.
r1 = 4.3;                   % base platform beam radius.

% nominal parameter values
omega = 6.5*(2.0*pi/60.0);  % radians / second.
r2 = 0.8;                   % car platform arm radius.
a1 = 0.058;                 % incline angle.
p0 = [omega r2 a1];

% set up the design space
lb = [0.3 0.1 0.0];         % parameter lower bounds.
ub = [0.8 1.5 0.3];         % parameter upper bounds.
Ns = 100;                   % number of samples.

% build the surrogate model
[x,y,hyp] = Surrogate(Tf,r1,a0,lb,ub,100);

% use fmincon to perform gradient based optimization
optns = optimoptions(@fmincon,...
    'Display','iter',...
    'Algorithm', 'sqp');
obj = @(p) OptObj(p,x,y,hyp);
p = fmincon(obj,p0,[],[],[],[],lb,ub,[],optns);