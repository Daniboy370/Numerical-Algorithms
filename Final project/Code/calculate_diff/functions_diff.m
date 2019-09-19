clc; close all;

% --------------------------------------------- %
u_100 = load('u_100'); u_100 = u_100.u;
u_750 = load('u_750'); u_750 = u_750.u;
% --------------------------------------------- %
v_100 = load('v_100'); v_100 = v_100.v;
v_750 = load('v_750'); v_750 = v_750.v;
% --------------------------------------------- %
w_100 = load('w_100'); w_100 = w_100.w;
w_750 = load('w_750'); w_750 = w_750.w;
% --------------------------------------------- %
psi_100 = load('psi_100'); psi_100 = psi_100.psi;
psi_750 = load('psi_750'); psi_750 = psi_750.psi;

del_u = u_100'-u_750';
del_v = v_100'-v_750';
del_w = w_100'-w_750';
del_psi = psi_100'-psi_750';


%% ------------------- u          function ---------------------- %
figure('rend', 'painters', 'pos', fig_loc);
contourf(x, y, del_u, 30, 'edgecolor', 'none'); colorbar;
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title('$\Delta u(x, y)$');
set(ind, 'Interpreter', 'latex', 'fontsize', 18); clear ind;
hold on; draw_boundaries; ylim([y(1) y(end)]);
pbaspect([3 1.5 1]); 

%% ------------------- v          function ---------------------- %
figure('rend', 'painters', 'pos', fig_loc); 
contourf(x, y, del_v, 30, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title('$\Delta v(x, y)$');
colorbar; set(ind, 'Interpreter', 'latex', 'fontsize', 18); clear ind;
hold on; draw_boundaries; ylim([y(1) y(end)]);
pbaspect([3 1.5 1]); 

%% ----------------------- Vorticity(x, y) ---------------------- %
figure('rend', 'painters', 'pos', fig_loc); 
contourf(x, y, del_w*.1, 20, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title('$\Delta \omega(x, y)$');
set(ind, 'Interpreter', 'latex', 'fontsize', 18); colorbar; 
hold on; draw_boundaries; ylim([y(1) y(end)]);
pbaspect([3 1.5 1]); 


%% ------------------ psi(x, y) vs. (u, v) -------------------- %
figure('rend', 'painters', 'pos', fig_loc); 
contourf(x, y, del_psi, 25, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title('$\Delta \psi(x, y)$');
set(ind, 'Interpreter', 'latex', 'fontsize', 18);  colorbar; hold on; 
% ----------- Add velocity streamlines ----------- %
draw_boundaries; ylim([y(1) y(end)]);
pbaspect([3 1.5 1]); ylim([y(1) y(end)]);

