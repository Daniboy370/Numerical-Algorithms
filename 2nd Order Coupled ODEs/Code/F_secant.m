function y_last = F_secant(x, Eqn, h, y0, u0, yf)
% ------------------ Description ---------------- %
% 
%   Auxiliary function to extract last element from RK vector
%
% ------------------- Algorithm ----------------- %
f_RK = @(u)  Runge_Kutta(x, Eqn, h, [y0 u]', 1);
y = f_RK(u0);                   % Temporary variable to hold vector
y_last = y(end) - yf;           % function's argument :: delta from BV
end
