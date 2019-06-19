% ------------- 2nd ODE : Hw_2016 ------------- %
% y'' + a_i y' + b_i y^2 = q_i; y(0) = k0, y(end) = kf ;
[beta, gam, phi] = deal(0.02, 20, 14.44);       % Problem's variables

% --- Physical problem :: Chemical Reaction --- %
[Tol, Omega] = deal(1e-8, 0.1);
a_n = @(x) 2/x;
b_n = @(x) 0;
C_x = @(y) (1 + beta - y)/beta;                % C(x) vs. T(x) relation
q_n = @(x, T) - phi^2*beta*(C_x(T))*exp( 1*(1-1/T) );

% -------------- Initialization --------------- %
[x_0, x_f] = deal(1e-2, 1);                     % X boundaries
[dT_0, T_f] = deal(1+beta, 1);

% ------------ Solution via MATLAB ------------ %
Eqn = @(x, Y) [Y(2); - a_n(x)*Y(2) - b_n(x)*Y(1) + q_n(x, Y(1)) ];
h_mat = 1e-3;   x_mat= x_0:h_mat:x_f;           % Iterative : X domain
y_Mat = Matlab_solution(x_mat, Eqn, dT_0, T_f);

% ----------- Solution via Shooting ----------- %
h_sht  = 1e-4;      x_sht = x_0:h_sht:x_f;          % x Domain : Shooting
[dy0_1, dy0_2] =    deal(0, 0+0.01);                % Important !: IG might converge with u @ Secant
[y_SHT, n_Sht] =    Shooting(x_sht, Eqn, h_sht, dT_0, T_f, dy0_1, dy0_2, Tol);

% ------------ Solution via iterative ------------ %
h_i = 0.01;                x_i = x_0:h_i:x_f;
i_num = length(x_i);       dy0_or_dyf = 1;
[y_GS , n_GS] = Gauss_Seidel(a_n, b_n, q_n, dy0_or_dyf, x_0, x_f, dT_0, T_f, i_num, h_i, Tol);
[y_SOR, n_SOR] =         SOR(a_n, b_n, q_n, dy0_or_dyf, x_0, x_f, dT_0, T_f, i_num, h_i, Tol, Omega);

%% ----------------- Plot Graph ---------------- %
fig_loc = [2300 250 800 500];
figure('rend', 'painters', 'pos', fig_loc); hold on; grid on;
plot(x_mat, y_Mat(1, :),  '-', 'linewidth', 3);
plot(x_sht, y_SHT      , '--', 'linewidth', 3);
plot(x_i  , y_GS       , '--', 'linewidth', 3);
plot(x_i  , y_SOR      , '--', 'linewidth', 3);

ind(1) = title('$T(x)$ vs. $x$');
ind(2) = xlabel('$x$');
ind(3) = ylabel('$T(x)$');
ind(4) = legend({'Matlab {$\textcopyright$}', 'Shooting', 'Gauss Seidel', 'SOR'}, 'location', 'southwest');
set(ind, 'Interpreter', 'latex', 'fontsize', 18 );
