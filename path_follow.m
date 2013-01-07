function Z = path_follow(dydt, z1, z2, M)
% Function for following the path of a fixed point through phase-parameter space
% Inputs:   dydt    -   handle to a function that calculates dy/dt = f(z)
%           z1, z2  -   two initial pints on the bifurcation curve where z = [y_1, ..., y_n, mu]
%           M       -   number of points on the bifurcation cure to calculate
%
% Outputs:  Z       -   matrix whose columns correspond to points on the bifurcation curve
tol = 1e-10;
ftol = 1e-8;
maxits = 100;
N = length(z1);
Z = zeros(N, M);
Z(:, 1) = z1;
Z(:, 2) = z2;

for I = 1:M-2
    zp = Z(:, I+1);     % most recent known point zp
    za = 2*zp-Z(:, I);  % initial approximation za
    fh = @(z)path_follow_func(dydt, z, za, zp);
    Z(:, I+2) = newton(fh, za, tol, maxits);
    
    %stop if Newton's method did not find a valid point:
    if ~(abs(path_follow_func(dydt, Z(:, I+2), za, zp)) < ftol)
        Z = Z(:, 1:I+1);
        return;
    end
end

   
