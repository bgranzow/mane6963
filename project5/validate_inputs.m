  function validate_inputs(func,x0,l,u)
% function validate_inputs(func,x0,l,u)
% ====
% Basic sanity check for inputs to the LBFGSB function.
% Inputs:
%  func - A function handle to the objective (must return [f,g]).
%  x0 - [n,1] Initial design vector.
%  l - [n,1] Lower bound constraint vector.
%  u - [n,1] Upper bound constraint vector.
% Outputs:
%  none.
% ====

if (~((nargout(func)==2)||(nargout(func)==-2)))
  error('objective func must return [f,g]');
end
if (~iscolumn(x0))
  error('x0 expected to be a column vector');
end
if (~iscolumn(l))
  error('l expected to be a column vector');
end
if (~iscolumn(u))
  error('u expected to be a column vector');
end
n = length(x0);
if (length(l)~=n)
  error('l expected to be of length n');
end
if (length(u)~=n)
  error('u expected to be of length n');
end
for i=1:n
  if (x0(i) < l(i))
    error('bounds error: x0(%d) < l(%d)!',i,i);
  end
  if (x0(i) > u(i))
    error('bounds error: x0(%d) > l(%d)!',i,i);
  end
  if (l(i) > u(i))
    error('bounds error: l(%d) > u(%d)!',i,i);
  end
  if (u(i) < l(i))
    error('bounds error: u(%d) < l(%d)!',i,i);
  end
end

end

