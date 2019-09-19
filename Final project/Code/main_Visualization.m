% ----------------------- Description ----------------------- %
%                                                             %
%               Plot variety of desired graphs                %
%                                                             %
% ------------------------- Content ------------------------- %

inner_field = 0; blank_scatter = zeros(size(psi));

% ------------ Nullify zero entries ------------ %
for i = 1:M
    for j = 1:N
        if ~check_if_inside_field(i, j, inner_field)
            [u(i, j), v(i, j), w(i, j), psi(i, j)] = deal(NaN, NaN, NaN, NaN);
            blank_scatter(i, j) = 1;
        end
    end
end


%% ------------------- u          function ---------------------- %
figure('rend', 'painters', 'pos', fig_loc);
contourf(x, y, u', 100, 'edgecolor', 'none'); colorbar;
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title(['$u(x, y)$ \ @ $Re =$ ', num2str(Re)]);
set(ind, 'Interpreter', 'latex', 'fontsize', 18); clear ind;
hold on; draw_boundaries; ylim([y(1) y(end)]);
h = streamslice(x, y, u', v', 3);
set(h, 'color', 'k', 'linewidth', 0.3); clear ind h;


%% ------------------- v          function ---------------------- %
figure('rend', 'painters', 'pos', fig_loc); 
contourf(x, y, v', 30, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title(['$v(x, y)$\ @ $Re =$ ', num2str(Re)]);
colorbar; set(ind, 'Interpreter', 'latex', 'fontsize', 18); clear ind;
hold on; draw_boundaries; ylim([y(1) y(end)]);
h = streamslice(x, y, u', v', 3);
set(h, 'color', 'k', 'linewidth', 0.3); clear ind h;

%% ----------------------- Vorticity(x, y) ---------------------- %
figure('rend', 'painters', 'pos', fig_loc); 
contourf(x, y, w'*.1, 40, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title(['$\omega(x, y)$\ @ $Re =$ ', num2str(Re)]);
set(ind, 'Interpreter', 'latex', 'fontsize', 18); colorbar; 
% ----------- Add velocity streamlines ----------- %
hold on; draw_boundaries; ylim([y(1) y(end)]);
pbaspect([3 1.5 1]); 

%% ------------ Vorticity :: Close up on nozzle --------------- %
figure('rend', 'painters', 'pos', fig_loc); 
[x_noz, y_noz] = deal( round(M/4), round(N/5) );
contourf(x(1:x_noz), y(1:y_noz), w(1:x_noz, 1:y_noz)'*.1, 14, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title(['$\omega(x, y)$\ @ $Re =$ ', num2str(Re)]);
set(ind, 'Interpreter', 'latex', 'fontsize', 18);
colorbar; pbaspect([3 1.5 1]);

%% ------------------ psi(x, y) vs. (u, v) -------------------- %
figure('rend', 'painters', 'pos', fig_loc); 
contourf(x, y, psi', 15, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title(['$\psi(x, y)$\ @ $Re =$ ', num2str(Re)]);
set(ind, 'Interpreter', 'latex', 'fontsize', 18);  colorbar; hold on; 
% ----------- Add velocity streamlines ----------- %
draw_boundaries; ylim([y(1) y(end)]);
pbaspect([3 1.5 1]); ylim([y(1) y(end)]);

% ---- Stream :: Close up on nozzle ---- %
figure('rend', 'painters', 'pos', fig_loc); 
[x_noz, y_noz] = deal( round(M/4), round(N/5) );
contourf(x(1:x_noz), y(1:y_noz), psi(1:x_noz, 1:y_noz)', 28, 'edgecolor', 'none');
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title(['$\psi(x, y)$\ @ $Re =$ ', num2str(Re)]);
set(ind, 'Interpreter', 'latex', 'fontsize', 18); hold on;
% ----------- Add velocity streamlines ----------- %
h = streamslice(x(1:x_noz), y(1:y_noz), u(1:x_noz, 1:y_noz)', v(1:x_noz, 1:y_noz)', 3);
set(h, 'color', 'k', 'linewidth', 0.4); clear ind h;
colorbar; pbaspect([3 1.5 1]);

%% ---------- Nozzle close up - velocity vector field ---------- %
figure('rend', 'painters', 'pos', fig_loc); clear X Y
[X,Y] = meshgrid(x(1:x_noz), y(1:y_noz));
pcolor(X, Y, hypot(u(1:x_noz, 1:y_noz)', v(1:x_noz, 1:y_noz)')); 
shading interp; hold on;
quiver(imresize(X, 1), imresize(Y, 1), imresize(u(1:x_noz, 1:y_noz)', 1), imresize(v(1:x_noz, 1:y_noz)', 1 ) );
% ------------ Fonts ------------ %
ind(1) = xlabel('x');
ind(2) = ylabel('y');
ind(3) = title(['Velocity vector field @ $Re =$ ', num2str(Re)]);
set(ind, 'Interpreter', 'latex', 'fontsize', 18); 
colorbar; pbaspect([3 1.5 1]); 

%% ---------- inlet vs. outlet close up - velocity vector field ---------- %
figure('rend', 'painters', 'pos', fig_loc); clear X Y
subplot(1, 2, 1);
[x_inlet, y_inlet] = deal( round(M/20), round(N/5) );
[X,Y] = meshgrid(x(1:x_inlet), y(1:y_inlet));
pcolor(X, Y, hypot(u(1:x_inlet, 1:y_inlet)', v(1:x_inlet, 1:y_inlet)')); 
shading interp; hold on;
quiver(imresize(X, 1), imresize(Y, 1), imresize(u(1:x_inlet, 1:y_inlet)', 1), imresize(v(1:x_inlet, 1:y_inlet)', 1 ) );
% ------------ Fonts ------------ %
ind(1) = xlabel('x'); ind(2) = ylabel('y');
ind(3) = title('Inlet Velocity field');
set(ind, 'Interpreter', 'latex', 'fontsize', 18); 
colorbar; ylim([0 1]); %pbaspect([3 1.5 1]); 

subplot(1, 2, 2);
[x_outlet, y_outlet] = deal( round(M - 1), round(3*N/4) );
[X,Y] = meshgrid(x(x_outlet:M), y(1:y_outlet));
pcolor(X, Y, hypot(u(x_outlet:M, 1:y_outlet)', v(x_outlet:M, 1:y_outlet)')); 
shading interp; hold on;
quiver(imresize(X, 1), imresize(Y, 1), imresize(u(x_outlet:M, 1:y_outlet)', 1), imresize(v(x_outlet:M, 1:y_outlet)', 1 ), ...
    'color', [1 0.75 0] );
% ------------ Fonts ------------ %
ind(1) = xlabel('x'); ind(2) = ylabel('y');
ind(3) = title('Outlet Velocity field');
set(ind, 'Interpreter', 'latex', 'fontsize', 18); 
colorbar; %pbaspect([1 1.5 1]); 
xlim([x(x_outlet) x(x_outlet) + dx/3.5]);
% ylim([0 5]);

%% ------------- Flow function vs. time evolution ------------- %
figure('rend', 'painters', 'pos', fig_loc);
t_lin = (0:i_step-2)*dt;

subplot(4, 1, 1);
ax(1) = plot(t_lin, u_ss  , 'LineWidth', 2.25); grid on;
ind(1) = title(['Flow evolution at orifice \ ($t \leq t_{ss}$)\ @ $Re =$ ', num2str(Re)]);
ind(2) = ylabel('$u(t)$'); xlim([0 t_lin(end)]);
subplot(4, 1, 2);
ax(2) = plot(t_lin, v_ss  , 'LineWidth', 2.25); grid on;
ind(3) = ylabel('$v(t)$'); xlim([0 t_lin(end)]);
subplot(4, 1, 3);
ax(3) = plot(t_lin, w_ss  , 'LineWidth', 2.25); grid on;
ind(4) = ylabel('$\omega (t) $'); xlim([0 t_lin(end)]);
subplot(4, 1, 4);
ax(4) = plot(t_lin, psi_ss, 'LineWidth', 2.25); grid on;
ind(5) = ylabel('$\psi (t) $'); ind(6) = xlabel('Time [sec]');
xlim([0 t_lin(end)]);
set(ind, 'Interpreter', 'latex', 'fontsize', 17); 

