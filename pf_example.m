%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Path follow with example 14.2.2 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set (gcf, "papersize", [6.4, 4.8])
set (gcf, "paperposition", [0, 0, 6.4, 4.8]) 

delta_mu = 10e-3;
iterations = 200;
z1 = [0; -1];
z2 = [0, -1+delta_mu];

function f = pitchfork_bif(z)
    f = z(2)*z(1) - z(1)^3;
end



Z = path_follow(@pitchfork_bif, z1, z2, iterations);
L = calculate_eigenvalues(@pitchfork_bif, Z);

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
hold on;
plot(-1, 0, '.o',"markersize", 10);
hold on;

axis([-1, 1, -1, 1]);
legend('stable', 'unstable', 'location', 'northwest');
legend("right");
xlabel ('mu');
ylabel ('y');
%title("pitchfork bifurcation y' = mu y - y^3");
title("pitchfork bifurcation");

print('grafik/pfexample1.pdf');


z12 = [1,1];
z22 = [1, 1-delta_mu];
Z2 = path_follow(@pitchfork_bif, z12, z22, iterations);
L2 = calculate_eigenvalues(@pitchfork_bif, Z2);
stable = [];
unstable = [];
for I = 1:iterations
    if L2(I) <= 0
        stable = [stable, I];
    else
        unstable = [unstable, I];
    end
end
plot(Z2(2,stable), Z2(1, stable), '-g', 'linewidth',5);
hold on;
plot(Z2(2,unstable), Z2(1, unstable), '--r', 'linewidth',5);
hold on;
plot(1, 1, '.o',"markersize", 10);

print('grafik/pfexample2.pdf');
hold off;


