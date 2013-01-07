
% hopf bifurcation example:

mu = mu_min:delta_mu:mu_max;
nudge = 1e-6;
t_trans = 100;
t_cycle = 100;
M = length(mu);
maxy = zeros(1, M);
miny = maxy;
fh = @(t, y)myrhs(]y; mu(1)]);

[t, Y] = ode
