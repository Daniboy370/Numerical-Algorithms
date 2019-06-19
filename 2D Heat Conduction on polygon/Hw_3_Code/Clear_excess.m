function u = Clear_excess( u, h, p )
% ---------------------- Description ---------------------- %
%                                                           %
%       This function assigns NaN values out of the         %
%       the polygon's boundaries.
%                                                           %
% --------------------- Initilization --------------------- %

x = @(i) (i*p);
y = @(x) (31-5*x)/3;
A = size(u); [i_max, j_max] = deal(A(1), A(2) ); % Framework size

for i = 2:i_max
    % -------- handle the diagonal ( 2 < x <= 5 ) --------- %
    if 2 < x(i) && x(i) <= 5 
        for j = 1:j_max
            if j > floor( y(x(i))/p ) + 1
                u(i, j) = NaN;
            end
        end
    end
end