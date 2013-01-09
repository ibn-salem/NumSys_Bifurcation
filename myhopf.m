function f = myhopf(z)
    a = 0.1;
    f = zeros(2,1);
    f(1) = -z(1) + a * z(2) + z(1)^2 * z(2);
    f(2) = z(3) - a*z(2) - z(1)^2 * z(2); 

% fixed point at:
