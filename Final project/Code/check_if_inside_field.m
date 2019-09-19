function flag = check_if_inside_field(i, j, inner_field)
% -------------------------- Description ------------------------- %
%                                                                  %
%           Checks whether current point is inside field           %
%                                                                  %
% --------------------------- Content ---------------------------- %
global L dx dy

cond = 1 - inner_field;

if ( cond )
    % ---------- Get flag approval for compartment only --------- %
    if (    (i >= 1                      && i <=round((L/10)  /dx - 2 )) && ( j>=1   && j<=round((L/20)  /dy+1 )) || ...
            (i >= round((L/10)/dx - 1)   && i <=round((3*L/20)/dx + 1 )) && ( j>=1   && j< round((L/40)  /dy )) || ...
            (i >= round((L/10)/dx + 1)   && i <=round((3*L/20)/dx + 1 )) && ( j>round((L/40)/dy +1) && j<=round((6*L/20)/dy+1 )) || ...
            (i >  round((3*L/20)/dx + 0) && i <=round((L    ) /dx + 1 )) && ( j>=1   && j<=round((6*L/20)/dy + 1)) )
        flag = 1;
    else
        flag = 0;
    end
else
    % ---------- Get flag approval for all solid walls ---------- %
    if (    (i >  1                      && i < round((L/10)  /dx-2  )) && ( j>1        && j<=round((L/20)  /dy  )) || ...
            (i >= round((L/10)/dx-2 )    && i <=round((3*L/20)/dx +1 )) && ( j>1        && j<=round((L/40)  /dy-2)) || ...
            (i >= round((L/10)/dx + 2)   && i <=round((3*L/20)/dx +1 )) && ( j> round((L/40)/dy+2) && j<=round((6*L/20)/dy) ) || ...
            (i >  round((3*L/20)/dx + 1) && i <=round((L     )/dx    )) && ( j>1        && j<=round((6*L/20)/dy  )) )
        flag = 1;
    else
        flag = 0;
    end
end

