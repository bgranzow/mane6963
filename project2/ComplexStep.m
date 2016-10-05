function dfdx = ComplexStep(f,x)

h = 1.0e-30;
assert(iscolumn(x));
nx = length(x);
dfdx = zeros(nx,1);
for j=1:nx
    ej = zeros(nx,1);
    ej(j) = 1.0;
    dfdx(j) = imag(f(x+1i*h*ej))/h;
end

end

