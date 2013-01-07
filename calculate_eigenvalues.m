function L = calculate_eigenvalues(dydt, Z)
% Function to calculate eigenvalues of the Jacobian at a number of points on a bifurcation curve
% Inputs:   dydt    -   handle to a function that calculates dy/dt=f(z)
%           Z       -   NxM matrix of points on the bifurcation curve as output from path_follow
% Outputs:  L       -   corresponding (N-1)xM matrix of eigenvalues
[N, M] = size(Z);
L = zeros(N-1, M);
for I = 1:M
    y = Z(1:N-1, I);
    mu = Z(N, I);
    % calculate Jacobian of dydt (treating mu as a constant):
    [f, J] = jacobian(@(y)dydt([y; mu]), y);
    L(:, I) = eig(J); % store eigenvalues in Ith column of L
end

