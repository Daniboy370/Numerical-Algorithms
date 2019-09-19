% -------------------------- Description ------------------------- %
%                                                                  %
%                       Initialize run values                      %
%                                                                  %
% --------------------------- Content ---------------------------- %
global L H dx dy

fig_loc = [400 250 1000 500];              % NOTE : locate window opening (!)
Range = @(i, f) i:f;                        % Function handle for segment
L = 20; H = 6*L/20;                         % Channel's dimensions

% ----------- Step size by dx dy ---------- %
dx = 0.2; dy = dx/5;                        % Step sizes
M = round(L/dx) + 1;                        % Defines the points number in y direction
N = round(H/dy) + 1;                        % Defines the points number in x direction
[evolution_x, evolution_y] = deal(round(M/10)+1, round(N/20)); % Center of shape

% ---------- Optimal Omega values --------- %
Meu = 0.5*abs(cos(pi/(M+1))+cos(pi/(N+1))); % SOR parameter
Omega = 2*((1-sqrt(1-(Meu^2)))/(Meu^2));    % SOR parameter
[conv_not_achieved, psi_flag] = deal(1, 1); % stop condition of while loop
[i_step, epsilon] = deal(1, 1e-3);          % Convergence condition
[inner_field, u_i, v_i] = deal(1, 1, 0);    % velocity values for dt

% ------ Steady state initialization ------ %
openfig('plot_epsilon_space');
openfig('plot_mesh_space');
t = 0; ss_zero = zeros(1e3, 1);             % initialize evolution functions
dt = 0.831;
