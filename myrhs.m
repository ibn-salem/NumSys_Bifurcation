function f = myrhs(z)
    f = zeros(2,1);
    f(1) = z(3) - z(1) - 4*z(1)*z(2) / (z(1)^2+1);
    f(2) = z(1)*(1-z(2) / (z(1)^2+1));
