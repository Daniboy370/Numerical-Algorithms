% ---------------------- Description ------------------ %
%                                                       %
%         Apply the set of boundary conditions          %
%                                                       %
% ---------------------- Content ---------------------- %

inner_field = 1;

% ------------------- Initialization ------------------ %
Mat = zeros(M, N);
for i = 1:M
    for j = 1:N
        if ~check_if_inside_field(i, j, inner_field)
            Mat(i, j) = 0;
        end
    end
end

[u, v, w, psi, dw_dt] = deal(Mat, Mat, Mat, Mat, Mat);   % Assign matrices
[x, y] = deal(linspace(0, L, M), linspace(0, H, N));                           % x, y axes

% ------------------------ BASE ------------------------ %
% ------------- A_1 B_1 :: 0 < x(i) < L ---------------- %
j = 1;                                  % y == 0
for i = Range( 1, round(L/dx) + 1 )
    u  (i, j) = 0;
    v  (i, j) = 0;
    psi(i, j) = 0;
    w  (i, j) = (2/dy^2)*( psi(i, 2) - psi(i, 1) );
end

% ------------------------- IN ------------------------- %
% ----------- A_1 H_1 :: 0 < y(j) < L/20 --------------- %
i = 1;                                      % x == 0
for j = Range( 1, round( (L/20)/dy ) )
    u  (i, j) = -4*y(j)^2     + 4*y(j);
    v  (i, j) = 0;
    psi(i, j) = -(4/3)*y(j)^3 + 2*y(j)^2;
    w  (i, j) = -8*y(j) + 4;
end
psi_in = max(max(psi));

% ------------------------------------------------------ %
% ----------- H_1 G_1 :: 0 < x(i) < L/10 --------------- %
j = round( (L/20)/dy) + 1;                      % y == L/20
for i = Range( 1, round( (L/10)/dx )-2 )
    u  (i, j) = 0;
    v  (i, j) = 0;
    psi(i, j) = psi_in;
    w  (i, j) = (2/dy^2)*( psi(i, j-1) - psi(i, j) );
end

% ------------------------------------------------------ %
% ----------- G_1-F_1 :: L/40 < y(j) < L/20 ------------ %
i = round( (L/10)/dx ) - 2;                 % x == 2L/20^-
for j = Range( round( (L/40)/dy) , round( (L/20)/dy) )
    u  (i, j) = 0;
    v  (i, j) = 0;
    psi(i, j) = psi_in;
    w  (i, j) = (2/dx^2)*( psi(i-1, j) - psi(i, j) );
end

% ------------------------------------------------------ %
% ---------- F_1 E_1-:: 2L/20 < x < 3L/20 -------------- %
j = round( (L/40)/dy ) - 1;                 % y == L/40^-
for i = Range( round( (2*L/20)/dx) - 2, round( (3*L/20)/dx) + 1 )
    u  (i, j) = 0;
    v  (i, j) = 0;
    psi(i, j) = psi_in;
    w  (i, j) = (2/dy^2)*( psi(i, j-1) - psi(i, j) );
end

% ------------------------------------------------------ %
% ------------- Side of compartment handle ------------- %
i = round( (3*L/20)/dx) + 1;
for j = Range( round( (L/40)/dy), round( (L/40)/dy)+1 )
    u  (i, j) = 0;
    v  (i, j) = 0;
    psi(i, j) = psi_in;
    w  (i, j) = (2/dx^2)*( psi(i+1, j) - psi(i, j) );
end

% ------------------------------------------------------ %
% ---------- F_1 E_1+:: 2L/20 < x < 3L/20 -------------- %
j = round( (L/40)/dy ) + 2;  j_EF = j; % y == L/40^+
for i = Range( round( (2*L/20)/dx) + 1, round( (3*L/20)/dx) + 1 )
    u  (i, j) = 0;
    v  (i, j) = 0;
    psi(i, j) = psi_in;
    w  (i, j) = (2/dy^2)*( psi(i, j+1) - psi(i, j) );
end

% ------------------------------------------------------ %
% ----------- F_1+ D  :: L/40 < y < L/20 --------------- %
i = round( (L/10)/dx ) + 1; i_FD = i; % x == 2L/20^+
for j = Range( j_EF + 1, round( (6*L/20)/dy) + 1 )
    u  (i, j) = 0;
    v  (i, j) = 0;
    psi(i, j) = psi_in;
    w  (i, j) = (2/dx^2)*( psi(i+1, j) - psi(i, j) );
end

% ------------------------------------------------------ %
% ----------- DC_sym  :: 0 < y(j) < L/20 --------------- %
j = round( (6*L/20)/dy ) + 1;               % x == L
for i = Range( i_FD, round( L/dx ) + 1 )
    %     u  (i, j) = 0; % <--- To be defined (!!!)
    v  (i, j) = 0;
    psi(i, j) = psi_in;
    w  (i, j) = 0;
end

% ------------------------- OUT ------------------------ %
% ----------- B_1 C_o :: 0 < y(j) < 6L/20 -------------- %
i = round( L/dx ) + 1;                      % x == L
for j = Range( 1, round( (6*L/20)/dy) + 1)
    u  (i, j) = -(1/216)*y(j)^2 + (1/18)*y(j)   ;
    v  (i, j) = 0;
    psi(i, j) = -(1/648)*y(j)^3 + (1/9) *y(j)^2 ;
    w  (i, j) = -(1/108)*y(j)   + (1/18)        ;
end
