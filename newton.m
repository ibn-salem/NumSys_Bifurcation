function x = newton(func, x, tol, maxits)
% see http://books.google.no/books?id=1rzEPpTofwoC&lpg=PP1&hl=de&pg=PA150#v=onepage&q=Newton&f=true
delta_x = 10*tol*x;
count = 0;
while ~(norm(delta_x, inf)/norm(x, inf) < tol) && count < maxits
    [f, J] = jacobian(func, x);
    delta_x = -J\f;
    x = x+delta_x;
    count = count + 1;
end
