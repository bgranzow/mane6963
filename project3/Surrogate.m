  function [x,y,hyp] = Surrogate(Tf,r1,a0,lb,ub,Ns)
% function [x,y,hyp] = Surrogate(Tf,r1,a0,lb,ub,Ns)
% Builds and trains the surrogate model to find hyperparameters.
% Inputs:
%   Tf - final nondimensional time for ODE solve.
%   r1 - base platform arm radius.
%   a0 - incline offset.
%   lb - lower bound for parameter design space
%   ub - upper bound for parameter design space
%   Ns - number of samples for the surrogate sampling.
% Outputs:
%   x - the lhs sampled design points.
%   y - the sampled objective values.
%   hyp - the hyperparameter struct.

% sample the design space.
Np = 3;
xn = lhsdesign(Ns,Np);
x = bsxfun(@plus,lb,bsxfun(@times,xn,(ub-lb)));

%{
% plot the design space and lhs points
scatter3(x(:,1),x(:,2),x(:,3))
set(gca, 'FontSize', 20, 'LineWidth', 2)
title('LHS design space')
xlabel('\omega')
ylabel('r_2')
zlabel('\alpha_1')
%}

% sample the objective function at the design points
y = zeros(Ns,1);
for i = 1:Ns
    omega = x(i,1);
    r2 = x(i,2);
    a1 = x(i,3);
    y(i) = Obj(Tf,r1,r2,a0,a1,omega);
end

% find the hyperparameters
covfunc = {@covMaterniso, 1};
hyp.cov = log([1/4; 1.0]);
likfunc = @likGauss;
sn = 0.025;
hyp.lik = log(sn);
hyp = minimize(hyp,@gp,-100,@infExact,[],covfunc,likfunc,x,y);

end