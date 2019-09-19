function flag = check_if_on_the_wall(i, j)
% -------------------------- Description ------------------------- %
%                                                                  %
%           Checks whether current point is on the wall            %
%                                                                  %
% --------------------------- Content ---------------------------- %
global L dx dy
                    % (!) Check the +1 on boundaries (!)
if (    ( (i>1 && i< (L)/dx )                    && ( j == 1 )               ) || ... % A_1 B_1
        ( (i>1 && i<=(L/10)/dx )                 && ( j == (L/20)/dy )       ) || ... % H_1 G_1
        ( (i == (L/10)/dx )        && ( j >= (L/40)/dy && j <= (2*L/20)/dy ) ) || ... % G_1-F_1
        ( (i >= (L/10)/dx && i <= (3*L/20)/dx )  && ( j == (L/40)/dy )       ) || ... % F_1 E_1-
        ( (i >= (L/10)/dx && i <= (3*L/20)/dx )  && ( j == (L/40)/dy + 1 )   ) || ... % F_1 E_1+
        ( (i == (L/10)/dx +1 )     && ( j >= (L/40)/dy && j <= (6*L/20)/dy ) ) || ... % F_1+D
        ( (i == (L/10)/dx +1 && i < (L)/dx)      && ( j == (6*L/20)/dy )     ) || ... % DC__sym
        ( (i == (L)/dx)            && ( j >= 1 && j <= (6*L/20)/dy )         )  )     % B_1 C_out
    flag = 1;
else
    flag = 0;
end
