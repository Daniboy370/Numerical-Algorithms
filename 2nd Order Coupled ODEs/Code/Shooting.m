function [y, count] = Shooting(x, Eqn, h, y0, yf, dy0_1, dy0_2, Tol)
% ------------------- Description ------------------- %
%
% Shooting method is a tool to estimate the former equation
% by comparing :: delta = Y(y0, yf) - BV = 0
%
% ----------------- Secant call ------------------ %
%           returns dy_0 that best fits
[dY_0, count] = Secant(x, Eqn, h, y0, yf, dy0_1, dy0_2, Tol);
%           returns the estimated function y(x)
y  = Runge_Kutta(x, Eqn, h, [y0 dY_0]', 1);
