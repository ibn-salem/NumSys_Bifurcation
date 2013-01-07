
set (gcf, "papersize", [6.4, 4.8])
set (gcf, "paperposition", [0, 0, 6.4, 4.8]) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Harvesting example:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%delta_mu = 0.5;
delta_mu = 10^(-2);
iterations = 2000;
z1 = [0; 0];
z2 = [0, 0+delta_mu];

function f = growth_harvesting(z)
    k = 0.1; M = 10;
    f = k*z(1) * (M - z(1)) - z(2);
end
Z = path_follow(@growth_harvesting, z1, z2, iterations);
L = calculate_eigenvalues(@growth_harvesting, Z);

stable = [];
unstable = [];
for I = 1:iterations
    if L(I) <= 0
        stable = [stable, I];
    else
        unstable = [unstable, I];
    end
end


plot(Z(2,stable), Z(1, stable), '-g', 'linewidth',5);
hold on;
plot(Z(2,unstable), Z(1, unstable), '--r', 'linewidth',5);

axis([0,3, 0, 10]);
xlabel ('mu');
ylabel ('y');
title("Bifurcation Diagram");
legend('stable', 'unstable');

print('grafik/harvesting.pdf');

hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot function:
n = 10
mu = 0;
t = -1:0.1:n;
z = zeros(2, n);
z(1,:) = t;
z(2,:) = mu;
f = [];
for I = t
    f = [f, growth_harvesting([I, mu])];
end

%hold on;


%z12 = [1,1];
%z22 = [1, 1-delta_mu];
%Z2 = path_follow(@pitchfork_bif, z12, z22, 2000);
%plot(Z2(2,:), Z2(1, :))

