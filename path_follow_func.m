function f = path_follow_func(dydt, z, za, zp)
N = length(z);
f = zeros(N, 1);
f(1: N-1) = dydt(z);
f(N) = (z-za)' * (za-zp);
