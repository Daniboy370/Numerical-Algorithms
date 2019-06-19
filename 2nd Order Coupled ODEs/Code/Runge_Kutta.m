function y = Runge_Kutta_2nd(x, f, h, IC, y_or_dy)
% ------------ Runge Kutta Algorithm ------------ %
% x - Domain of values
% f - Desired function @(handle)
% h - Step size
% IC -[Y(0), dY(0)]
% [Y1 Y2] = [ M_{i}{j} ] [Y(2); -Y(1)] <-- State vector
% ----------------------------------------------- %

Y = IC;
for i  = 1:length(x)-1
    k1 = h*f( x(i)    , Y(:,i)        );
    k2 = h*f( x(i)+h/2, Y(:,i) + k1/2 );
    k3 = h*f( x(i)+h/2, Y(:,i) + k2/2 );
    k4 = h*f( x(i)+h  , Y(:,i) + k3   );
    Y(:,i+1) = Y(:,i) + (1/6)*( k1 + 2*k2 + 2*k3 + k4 );
end

if (y_or_dy == 1)           % flag : y / dy == 1 / 2
    y = Y(1,:);
else
    y = Y(2,:);
end

% --------------- EXAMPLE :: Sinus -------------- %
% f = @(x, Y) [Y(2); -Y(1)];
% [x0, xf] = deal(0, 4*pi);
% h = 0.01;  x = x0:h:xf; IC = [0 1]';
% y = Runge_Kutta_2nd(x, f, h, IC);
% ----------------------------------------------- %