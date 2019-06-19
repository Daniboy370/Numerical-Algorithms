function [dY, n] = Secant(x, Eqn, h, y0, yf, dy0_1, dy0_2, Tol)
% ------------------ Description ---------------- %
%
%   Using the secant method to find 'u' function's roots
%   dy0_1, dy0_2, starting with initial guesses
%
% ----------------------------------------------- %
    function y_last = F_delta(x, Eqn, h, y0, u0, yf)
        % ------------- Description ------------- %
        %
        %   Auxiliary function to extract last element from RK vector
        %
        % ---------------- Code ----------------- %
        f_RK = @(dy)  Runge_Kutta(x, Eqn, h, [y0 dy]', 1);
        y = f_RK(u0);                   % Temporary variable to hold vector
        y_last = y(end) - yf;           % function's argument :: delta from BV
    end

% ----------------- Initilization --------------- %
N = 50;                                           % Upper loop's boundary
[u(1), u(2)] = deal(dy0_1, dy0_2);                % u == dy_0
F   = @(u0)   F_delta(x, Eqn, h, y0, u0, yf);

err = inf; n = 0; eps = 1e-10;
% -------------- Secant Algorithm --------------- %
while (err > Tol && n < N-2)
    n = n + 1;
    u(n+2) = u(n+1) - F(u(n+1)) * ( u(n+1) - u(n) )/( F(u(n+1)) - F(u(n)) + eps );
    err = abs(u(n+1) - u(n));
end

dY = u(n+2);            % argument :: initial dy_0 that produces smallest delta
end