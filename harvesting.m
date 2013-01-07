

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Harvesting example:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta_mu = 10^(-2);
z1 = [0; 0];
z2 = [0, 0+delta_mu];

function f = growth_harvesting(z)
    k = 0.1; M = 10;
    f = k*z(1) * (M - z(1)) - z(2);
end
Z = path_follow(@growth_harvesting, z1, z2, 2000);
plot(Z(2,:), Z(1, :))
axis([0,3, 0, 10]);
print('harvesting.pdf')
%xlabel ('\mu')
xlabel('\partial{P_k}(t_i)/\partial{S}_{p}(z_j)');
%hold on;

%z12 = [1,1];
%z22 = [1, 1-delta_mu];
%Z2 = path_follow(@pitchfork_bif, z12, z22, 2000);
%plot(Z2(2,:), Z2(1, :))

