

% Fix point analysis:

% RHS:
printf("debug\n");

% initial solution:
y0 = [1;1];

% find fix points by newton's mehtod:
%y_star = newtroot(@lv_logistic, y0)
y_star = newton(@lv_logistic, y0, 1e-10, 100)
%my_newton(@lv_logistic, y0, 1e-10, 100)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Path follow with example 14.2.1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = fold_bif(z)
    f = z(1) - z(1)^4 + z(2);
end
z1 = [0;0];
delta_mu = 10^(-3);
z2 = [0;0-delta_mu];
Z = path_follow(@fold_bif, z1, z2, 1000);
L = calculate_eigenvalues(@fold_bif, Z);
%plot(Z(2,:), Z(1, :))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Path follow with example 14.2.3 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z1 = [0; -1];
z2 = [0, -1+delta_mu];

function f = pitchfork_bif(z)
    f = z(2)*z(1) - z(1)^3;
end
Z = path_follow(@pitchfork_bif, z1, z2, 2000);
plot(Z(2,:), Z(1, :))

hold on;

z12 = [1,1];
z22 = [1, 1-delta_mu];
Z2 = path_follow(@pitchfork_bif, z12, z22, 2000);
plot(Z2(2,:), Z2(1, :))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Harvesting example:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

