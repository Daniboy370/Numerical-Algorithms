function [u, u_valid, run_time] = Hw_2_calc_u(h, k)
% ----------------------- Description ---------------------- %
%                                                            %  
%           This function calculates the main PDE            %
%                                                            %
% ----------- Initialize vectors of the problem ------------ %
global omega t_0 t_f r_0 r_f
t = t_0:k:t_f; t_N = length(t);
r = r_0:h:r_f; r_N = length(r); r = r';

% --------- Numeric Method == u_{j,i} <=> u_{r, t} ---------- %
u_m1 = eps;
u_p1  = @(t) sin(omega*t);              % B.C is f(t) and changes by j
u = zeros(r_N, t_N);                    % Fulfill boundary conditions
nOnes = ones(r_N, 1);
[R,   Q] = deal((k/h^2), (k/(2*h)) );
[Rm, Qm] = deal(nOnes * R, nOnes(1:end-1) * Q );

% ------------------ Consruct Matrix From ------------------ %
C_1 = diag(Rm(1:end-1) + Qm./r(1:(end-1)), 1);
C_2 = diag(1  - 2*Rm   -  k./r.^2,         0);
C_3 = diag(Rm(2:end)   - Qm./r(2:end),    -1);
A_r = C_1 + C_2 + C_3; b = zeros(r_N, 1);

% ------- Extract vector u_{j,:} every time step (j) ------- %
tic;
for j = 1:t_N-1
    [b(1), b(end)] = deal(u_m1*(R - Q/r(1)), u_p1(t(j+1))*(R + Q/r(end)) );
    u(:, j+1) = A_r*u(:, j) + b;
end            % --- Final matrix - u_{T, R} --- %
run_time = toc;               % Return elapsed computation time
u_valid = abs(max(max(u)));