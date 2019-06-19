function U_n_1 = Gauss_Seidel( U_n, F, h, p)
% ---------------------- Description ---------------------- %
%                                                           %
%       Gauss-Seidel method iteratively calculates          %
%       the u^(n+1)_{i, j} element along (i, j) grid        %
%       returns : Matrix at iteration (n)                   %
%                                                           %
% --------------------- Initilization --------------------- %

x = @(i) (i*p);
y = @(x) (31-5*x)/3;
A = size(U_n); [i_max, j_max] = deal(A(1), A(2) ); % Framework size

U_n_1 = U_n;                                % Init. Matrices
% ----------------------- 0 < x < 5 ----------------------- %
U_n_1(:, 1) = U_n_1(:, 1+2);                % AB :: du(0) = 0
% -------------------- (x=0, 0 < y < 7 ) ------------------ %
U_n_1(1, :) = 1;                            % AE ::  u    = 1

for i = 2:i_max - 1
    % ------------------- 0 < x < 2 ----------------------- %
    if  x(i) <= 2
        for j = 2:j_max - 1                 % 0 <= y <= 5
            U_n_1(i, j) = F(U_n, U_n_1, i, j);
        end
        U_n_1(i, j+1) = U_n_1(i, j-1);      % DE :: du(0) = 0
        % --------------- 2 < x < 5 ----------------------- %
    elseif x(i) < 5
        for j = 2:floor( y(x(i))/p )        % 0 <= y <= (31-5x)/3
            U_n_1(i, j) = F(U_n, U_n_1, i, j);
        end
        U_n_1(i, j+1) = 0;                  % CD ::  u    = 0
    end
U_n = U_n_1;                            % Swap Matrices
end
% ------------------------- x == 5 ------------------------ %
U_n_1(i+1, 1:j) = 0;                          % BC ::  u    = 0