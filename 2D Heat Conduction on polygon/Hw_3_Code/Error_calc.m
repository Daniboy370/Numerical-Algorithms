function err = Error_calc(y2, y1, choice)

% --- Calculate error magnitude by chosen approach --- %
switch choice
    case 1
        % -------------- Absolute error -------------- %
        err = abs( sum(sum(y2 - y1)) );
    case 2
        % -------------- Relative error -------------- %
        err = abs( 1 - sum(sum(y1))/sum(sum(y2)) );
    case 3
        % ------------ Normalized error -------------- %
        err = sqrt( sum(sum( (y2 - y1).*(y2 - y1) )) )/length(y2);
end