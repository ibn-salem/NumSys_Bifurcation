
% hopf bifurcation example:

%set (gcf, 'papersize', 1.5*[6.4, 4.8])
%set (gcf, 'paperposition', 1.5*[0, 0, 6.4, 4.8]) 


mu_min = 0.2;
mu_max = 1;
delta_mu = 0.001;
iterations = 200;

% start value:
%y_zero = [1; 1; 1];
%y_zero = [2; 2/5; 2];
y_zero = [0.2; 1.43; 0.2];
%y_star = newton(@myhopf, y_zero, 1e-10, 100)
%y_star = [2; 2/5];
y_star = [0.2; 1.43];
%y_star = [-3; 3/10];

mu = mu_min:delta_mu:mu_max;
nudge = 1e-6;
t_trans = 50;
t_cycle = 50;
M = length(mu);
maxy = zeros(1, M);
miny = maxy;
fh = @(t, y)myhopf([y; mu(1)]);

[t, Y] = ode45(fh, [0, t_trans], (1+nudge)*y_star);

for I = 1:M
    mu(I)
    fh = @(t, y)myhopf([y; mu(I)]);
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

% calculate bifurcation diagram for starting value with standart method:
z1 = [0.2; 1.43; 0.2];
z2 = [0.2; 1.43; 0.2+delta_mu];
Z = path_follow(@myhopf, z1, z2, iterations);
L = calculate_eigenvalues(@myhopf, Z);

% get stability values:
stable = [];
unstable = [];
norm_stable = [];
norm_unstable = [];

for I = 1:iterations
    if max(real(L(:,I))) <= 0
        stable = [stable, I];
        norm_stable = [norm_stable, norm(Z(1:2, I), 2)];
    else
        unstable = [unstable, I];
        norm_unstable = [norm_unstable, norm(Z(1:2, I), 2)];
    end
end

% get |y| for plotting:
%for I = 1:length(stable)
%    norm_stable = [norm_stable, norm(Z(1:2, I), 2)];
%end
%for I = 1:length(unstable)
%    norm_unstable = [norm_unstable, norm(Z(1:2, I), 2)];
%end


ax = gca();
set(ax, 'fontsize', 10);

%plot(Z(2,stable), Z(1, stable), '-g', 'linewidth',5);
pc1 = plot(mu, miny, '--b', 'linewidth',5 , mu, maxy, '--b', 'linewidth',5);
hold on;
ps = plot(Z(3,stable), norm_stable, '-g', 'linewidth',5);
hold on;
pu = plot(Z(3,unstable), norm_unstable, '--r', 'linewidth',5);
axis([0, 1, 0.5, 2.5]);
xlabel('b')
ylabel('norm(x,y)')
%legend([pc1, ps], 'bla', 'blub');
%legend([p1, ps, pu],{'stable periodic orbit', 'stavle fixed point', 'unstable fixed poind', 'location', 'northwest'});
#legend('{\fontsize{10} stable periodic orbit}', '', 'stable fixed point', 'unstable fixed poind', 'location', 'northwest');
legend('stable periodic orbit', '', 'stable fixed point', 'unstable fixed poind', 'location', 'northwest');
print('grafik/myhopf.png');
hold off;
