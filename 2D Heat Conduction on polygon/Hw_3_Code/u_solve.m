function [u_n, n_iter] = u_solve( u_n, alpha, K_10, K_20, h, p, Omega, err )
% -------------------------- Description ------------------------- %
%                                                                  %
%  This function receives a desired system of equations to solve   %
%  and return the calculted matrix using GS method by chosen err   %
%                                                                  %
% ---------------------- Define the problem ---------------------- %

[k1, k2] = deal(K_10/h^2, K_20/p^2);
X_ij = @(U_n_1, U_n, i, j, sgn) ( U_n(i+1,j) +sgn * U_n_1(i-1,j) );
Y_ij = @(U_n_1, U_n, i, j, sgn) ( U_n(i,j+1) +sgn * U_n_1(i,j-1) );

% ------------------- Define governing method -------------------- %
F = @(U_n, U_n_1, i, j) ( ( k1*X_ij(U_n, U_n_1, i, j, +1) + k2*Y_ij(U_n, U_n_1, i, j, +1) )...
    + (alpha/(1+alpha*U_n(i,j))/4)*( k1*X_ij(U_n, U_n_1, i, j, -1)^2 +...
    k2*Y_ij(U_n, U_n_1, i, j, -1)^2 ) )/(2*(k1 + k2));

[n_iter, u_SOR, u_GS] = deal(1, u_n/100, 0);        % Initialization
[err_abs, err_rel, err_RMSE] = deal(1, 2, 3);
% --------------------- Iterative convergence -------------------- %
while Error_calc(u_SOR, u_n, err_RMSE) > err
    if (n_iter > 1)
        u_n = u_SOR;
    end
    u_GS = Gauss_Seidel(u_n, F, h, p);
    u_SOR = u_n + Omega * ( u_GS - u_n );
    n_iter = n_iter + 1;
end
u_n = u_SOR;