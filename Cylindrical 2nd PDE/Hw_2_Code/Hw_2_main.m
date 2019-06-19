clc; close all; clear; set(0, 'defaultfigurecolor', [1 1 1]);
% ----------------------- Description ---------------------- %
%                                                            %  
%              The main script of the program                %
%                                                            %
% ----------- Initialize values of the problem ------------- %
global omega t_0 t_f r_0 r_f
[k, h]     = deal(1e-4, 2e-2);         
[r_0, r_f, t_0, t_f ] = deal(h,   1.0, k, 10);
[h_max, k_max, omega] = deal(0.1, 0.2, 1);
marker_size = 70;

% ---------------- Mesh of permissible R's ----------------- %
[mesh_x, mesh_y] = deal(12, 10);
h_mesh = logspace(log10(0.005),    log10(h_max), mesh_x);
k_mesh = logspace(log10(0.00001), log10(k_max), mesh_y);
R = k_mesh'./h_mesh.^2; R_log = (R < 0.5); R_valid = R_log .* R;
Run_time = zeros(mesh_y, mesh_x);

% --------------------- Solution space --------------------- %
for i = 1:mesh_y
    for j = 1:mesh_x
        if ( R_valid(i, j) ~= 0 )
            [~, u_valid, Run_time(i, j)] = Hw_2_calc_u(h_mesh(j), k_mesh(i));      % Calculate current f(h, k)
            if u_valid > 1         % Sanity check
                Run_time(i, j) = 0;
            end
        end
    end
end

fig_loc = [1900 250 1200 500]; % << -- !! Remove on 1 screen !!
figure('rend', 'painters', 'pos', fig_loc); hold on; grid on;

t_max = max(max(Run_time));
for i = 1:mesh_y
    for j = 1:mesh_x
        if ( R_valid(i, j) ~= 0 )
            scatter3(k_mesh(i), h_mesh(j), R_valid(i, j), marker_size, 'MarkerEdgeColor','k',...
                'MarkerFaceColor', (Run_time(i, j)/t_max)*[1 1 1]);
        else
            scatter3(k_mesh(i), h_mesh(j), R_valid(i, j), marker_size, 'MarkerEdgeColor','k',...
                'MarkerFaceColor', [1 0 0]);
        end
    end
end

% -------------------- Graph properties --------------------- %
set(gca, 'xScale', 'log');
set(gca, 'YScale', 'log');
colormap(gray(256)); colorbar; caxis([0 t_max]); view(-34, 21);
ind(1) = title('$f(R, t)$ vs. $h$ vs. $k$');
ind(2) = xlabel('$k$ [sec]');
ind(3) = ylabel('$h$ [m]');
ind(4) = zlabel('$R$ [${sec}/{h^2}$]');
set(ind, 'Interpreter', 'latex', 'fontsize', 18 );

%% -------- Extract optimal R w.r.t time performance -------- %

min_val = min( Run_time(Run_time(:)>0)  ); 
[m_min, n_min] = find(Run_time == min_val);
[h, k] = deal(h_mesh(n_min), k_mesh(m_min));

for i = 1:2
    omega = i;
    % ----------------- Plot the Optimal graph ----------------- %
    t = t_0:k:t_f; t_N = length(t);
    r = r_0:h:r_f; r_N = length(r); r = r';
    [u, ~, ~] = Hw_2_calc_u(h, k);
    
    [m, n] = size(u);
    [m_r, n_r] = deal(1, 500);               % Reduction factor
    t_s = linspace(t_0, t_f, floor(n/n_r));
    r_s = linspace(r_0, r_f, floor(m/m_r)); %r_s = r_s';
    u_s = Hw_2_downsize(u, m_r, n_r);   % Down size the matrix' dimensions
    
    fig_loc = [1900 250 800 500]; % << -- !! Remove on 1 screen !!
    figure('rend', 'painters', 'pos', fig_loc); hold on; grid on;
    surf(r_s, t_s, u_s');           % Plot the reduced dimension matrix
    alpha(0.8); view([-52 22]);
    
    % ------------- Labels ------------- %
    ind(1) = title(['$u(r, t) = f_{F.D}(h=', num2str(h), ', k=', num2str(k) ')$']);
    ind(2) = xlabel('r [$m$]');
    ind(3) = ylabel('Time [sec]');
    ind(4) = zlabel('$\delta$ [$m$]');
    set(ind, 'Interpreter', 'latex', 'fontsize', 18 );
    
end
