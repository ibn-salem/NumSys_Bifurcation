
% hopf bifurcation example:

mu_min = 1;
mu_max = 10;
delta_mu = 0.01;

% start value:
y_zero = [1, 1]
y_star = newton(@myrhs, y_zero, 1e-10, 100)

mu = mu_min:delta_mu:mu_max;
nudge = 1e-6;
t_trans = 100;
t_cycle = 100;
M = length(mu);
maxy = zeros(1, M);
miny = maxy;
fh = @(t, y)myrhs(]y; mu(1)]);

[t, Y] = ode45(fh, [0, t_trans], (1+nudge)*y_star);

for I = 1:M
    fh = @(t, y)myrhs([y; mu(I)]);
    y0 = Y(size(Y, 1), :);
    [t, Y] = ode45(fh , [0, t_cycle], y0);
    % calc norm of y at each point on the orbit:
    P = size(Y, 1);
    y_norm = zeros(P, 1);
    for J = 1:P;
        y_norm(J) = norm(Y(J, :));
    end
    % recorde min and max of norm:
    maxy(I) = max(y_norm);
    miny(I) = min(y_norm);
end

%plot(mu, miny, mu, maxy)

