% -------------------------- Description -------------------------- %
%                                                                   %
%                 Draw the inner compartments spaces                %
%                                                                   %
% ---------------------------- Content ---------------------------- %

for i = 2:M
    for j = 1:N-1
        if ~check_if_inside_field(i, j, inner_field)
            scatter( (i-1)*dx, (j-1)*dy, 25, 'k+' )
        end
    end
end
