function err = Error_calc(y2, y1)
% --- Calculate error magnitude by chosen approach --- %
err = sqrt( sum(y2 - y1)^2 )/length(y2);
end