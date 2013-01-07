function [f0, J] = jacobian(func, x)
% see http://books.google.no/books?id=1rzEPpTofwoC&lpg=PP1&hl=de&pg=PA151#v=onepage&q=Newton&f=true
N = length(x);
dx = 1e-10;
f0 = func(x);
J = zeros(N);
for I = 1:N;
    x0 = x(I);
    x(I) = x(I)+dx;
    f = func(x);
    J(:, I) = (f-f0)./dx;
    x(I) = x0;
end

