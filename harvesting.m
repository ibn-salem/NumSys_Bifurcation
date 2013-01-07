set (gcf, "papersize", [6.4, 4.8])
set (gcf, "paperposition", [0, 0, 6.4, 4.8]) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Harvesting example:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%delta_mu = 10^(-2);
delta_mu = 0.5;
z1 = [0; 0];
z2 = [0, 0+delta_mu];

function f = growth_harvesting(z)
    k = 0.1; M = 10;
    f = k*z(1) * (M - z(1)) - z(2);
end
Z = path_follow(@growth_harvesting, z1, z2, 200);
L = calculate_eigenvalues(@growth_harvesting, Z);

plot(Z(2,:), Z(1, :), '10');
axis([0,3, 0, 10]);
xlabel ('mu')
ylabel ('y')
title("Bifurcation Diagram")
print('grafik/harvesting.pdf')

%hold on;

%z12 = [1,1];
%z22 = [1, 1-delta_mu];
%Z2 = path_follow(@pitchfork_bif, z12, z22, 2000);
%plot(Z2(2,:), Z2(1, :))

