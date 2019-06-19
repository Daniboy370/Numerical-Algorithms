function dy0_Finder(x, Eqn, h_s, y0, yf, dy_min, dy_max, Tol)
% ------------------- Description ------------------- %
%
% Due to Secant's natural sensitivity to the dy_0 initial 
% conditions, one has to gently finetune the random range
% for which the shooting method will work properly
%
% ------- Checking random values across range ------- %

IG_res = 20; 
i_lin = linspace(dy_min, dy_max, IG_res); IG_stack = zeros(IG_res, 1);
delta = i_lin(2) - i_lin(1);
for i = 1:IG_res
    [dy0_1, dy0_2] = deal(i_lin(i), i_lin(i) + delta); 
    [y_shoot, ~] = Shooting_NL(x, Eqn, h_s, y0, yf, dy0_1, dy0_2, Tol);
    if (~isnan(y_shoot(end/2)))
        IG_stack(i) = 1;
    else
        IG_stack(i) = 0;
    end
end

fig_loc = [2300 250 800 500];
figure('rend', 'painters', 'pos', fig_loc); hold on; grid on;
plot(i_lin, IG_stack, '--', 'linewidth', 1);
plot(i_lin, IG_stack, '*', 'linewidth', 5);
ind(1) = title('Initial Condition search engine');
ind(2) = xlabel('$dy_0$');
ind(3) = ylabel('Initial Guess works ?');
set(ind, 'Interpreter', 'latex', 'fontsize', 18 );