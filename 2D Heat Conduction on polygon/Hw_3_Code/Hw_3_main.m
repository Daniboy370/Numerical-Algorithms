clc; close all; clear; set(0, 'defaultfigurecolor', [1 1 1]);
% ----------------------- Description ---------------------- %
%                                                            %
%              The main script of the program                %
%                                                            %
% ----------- Initialize values of the problem ------------- %

fig_loc = [800 250 475*1.012 555*1.012];
[xf, yf, step_size] = deal(5, 7, 1/20);
h = step_size; p = h;
[x, y] = deal(h:h:5, p:p:7);                        % x and y axes
alpha = [0, 0.1, 0.1, 0.1];
K_10  = [1,   1,   1,   1];
K_20  = [1,   1, 1/2,   2];
[initial_guess, err, omega, n_iter] = deal(0.5, 1e-4, 1.15, zeros(4, 1));
u_sol = zeros(length(x), length(y), 4);

% ------------ Solve 4 variations of the problem ----------- %
for i = 1:length(alpha)
    u = ones(length(x), length(y))*initial_guess;   % b.c. :: Compliant matrix
    u(1, :) = 1;                                    % i.c. :: u_{AE} = 1
    [u_sol(:, :, i), n_iter(i)] = u_solve( u, alpha(i), K_10(i), K_20(i), h, p, omega, err );
    u_sol(:, :, i) = Clear_excess(u_sol(:, :, i), h, p);  % Clear polygon
    
    figure('rend', 'painters', 'pos', fig_loc);
    [~, c] = contourf(x, y, u_sol(:, :, i)', '--', 'ShowText','on');
    c.LineWidth = 2.0; colorbar; hold on;
    % ----------- plot diagonal boundaries (?) of the polygon ----------- %
    x_diag = 2:h:5;   y_diag = (31 - 5.*x_diag )./3 ;
    plot(x_diag, y_diag, 'linewidth', 2, 'color', 'black');
    
    ind(1) = title(['$u_{i,j}$($\alpha$=', num2str(alpha(i)), ', $K_{10}$=', num2str(K_10(i)),...
        ', $K_{20}$=', num2str(K_20(i)), ')']);
    ind(2) = xlabel('$x$');
    ind(3) = ylabel('$y$');
    set(ind, 'Interpreter', 'latex', 'fontsize', 18 );
end