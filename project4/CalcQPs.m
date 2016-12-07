  function [pts, wts] = CalcQPs(w,L)
% function [pts, wts] = CalcQPs(w,L)
% Precompute shifted Gauss-Hermite integration data
% Inputs:
%  w - Total weight acting on a single spar.
%  L - Length of the spar.
% Outputs:
%  pts - [81,4] vector - all combinations of [xi1,xi2,xi3,xi4] data.
%  wts - [81,1] vector - all combinations of wi*wj*wk*wl data.

fnom0 = 2*w/L;
mu = [0,0,0,0];
sigma = fnom0*[1/10, 1/20, 1/30, 1/40];

Nqp = 3;
xi = [-1.22474487139; 0.0; 1.22474487139];
w = [0.295408975151; 1.1816359006; 0.295408975151];
pts = zeros(81,4);
wts = zeros(81,1);

i = 1;
for i1=1:Nqp
    xi1 = sqrt(2)*sigma(1)*xi(i1) + mu(1);
    for i2=1:Nqp
        xi2 = sqrt(2)*sigma(2)*xi(i2) + mu(2);
        for i3=1:Nqp
            xi3 = sqrt(2)*sigma(3)*xi(i3) + mu(3);
            for i4=1:Nqp
                xi4 = sqrt(2)*sigma(4)*xi(i4) + mu(4);
                pts(i,:) = [xi1, xi2, xi3, xi4];
                wts(i) = w(i1)*w(i2)*w(i3)*w(i4)/(sqrt(pi)^4);
                i = i+1;
            end
        end
    end
end

end