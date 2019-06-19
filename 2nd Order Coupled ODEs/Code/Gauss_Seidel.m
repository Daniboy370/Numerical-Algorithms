function [y, count] = Gauss_Seidel(a_n, b_n, q_n, dy0_or_dyf, x0, xf, y0, yf, i_num, h, Tol)
% ------------------ Description ---------------- %
%
% Using Gauss Seidel method to iteratively compose estimated 'y'
%   (!) -- dy(xf) : Forces n = 1,2,...,N+1
%        << given y_i^2 in 2nd order Eq. >>
%
% ----------- Initialization (Ay = b) ----------- %
N = 1e4;                                          % safety Maximum iterations
x = x0:h:xf;                                      % X Domain
A = zeros(i_num, i_num);                          % A   Memory allocation
b = zeros(i_num, 1);                              % Initialize b vector
y_N = ones(2, i_num);                             % y_n Memory allocation
y_N_GS = ones(2, i_num);                          % y_n Memory allocation

% ---------------- Coefficients ----------------- %
%   Add @(x, y) function handle where necessary
C_1 = @(x_i)  1 - (a_n(x_i)*h/2);
C_2 = @(x_i) -2 + (b_n(x_i)*h^2);
C_3 = @(x_i)  1 + (a_n(x_i)*h/2);

% -------- Adaptation :: dy_i conditions -------- %
% When no [y0,yf] given :: x_range increased by '1' !
if dy0_or_dyf == 0         % case [y(0), y(f)] :: Defaultive
    y_0 = @(y, i) y0;              y_f = @(y, i) yf;
elseif dy0_or_dyf == 1     % case [y(f), dy_0] :: y(f) unchanged
    y_0 = @(y, i) y(i+1) - 2*h*y0; y_f = @(y, i) yf;
else                       % case [y(0), dy_f] :: y(0) unchanged
    y_f = @(y, i) y(i-1) + 2*h*yf; y_0 = @(y, i) y0;
end

% --------------- n_{th} iteration -------------- %
err = inf; n = 1;
while (err > Tol && n < N)
    % ------------ Initialize vector ------------ %
    y_N(1, :) = y_N(2, :);                        % y_N(old) >> y_N(new)
    y_N_GS(1,:) = y_N_GS(2, :);                   % Swap old y_N_GS with new
    % -------------- A, b : Update -------------- %
    for i = 1:i_num                               % N = i_num - 1
        % ------------ Assign entries ----------- %
        if i == 1
            [A(i, i), A(i, i+1)] = deal(C_2(x(i)), C_3(x(i)) );
            b(i) = h^2*q_n(x(i), y_N(1, i)) - y_0(y_N(1, :), i)*C_1(x(i));
        elseif i < i_num
            [A(i, i-1), A(i, i), A(i, i+1)] = deal(C_1(x(i)), C_2(x(i)), C_3(x(i)));
            b(i) = h^2*q_n(x(i), y_N(1, i));
        else
            [A(i, i-1), A(i, i)] = deal(C_1(x(i)), C_2(x(i)) );
            b(i) = h^2*q_n(x(i), y_N(1, i)) - y_f(y_N(1, :), i)*C_3(x(i));
        end
    end
    % ---- Extract Upper & Lower triangular ----- %
    Lp = tril(A); U = triu(A,1);                  % Lp == Lower dominant
    % -------------- A_{n} iteration ------------ %
    y_N(2, :) = Thomas_Algorithm(Lp, b - U*y_N(1, :)');
    err = Error_calc(y_N(2,:), y_N(1,:));
    n = n + 1;
end
% -------------------- Output ------------------- %
count = n;
y = y_N(2, :);                % n = 2 :: Most updated
