function A_reduced = Hw_2_downsize(u, m_r, n_r)
% ----------------------- Description ---------------------- %
%                                                            %  
%            Dimensionallity reduction algorithm             %
%                                                            %
% ----------- Initialize vectors of the problem ------------ %
global t_0 t_f r_0 r_f
[m, n] = size(u);
[i_r, j_r] = deal(floor(m/m_r), floor(n/n_r));   % maximal number to stay in range
A_reduced = zeros(i_r, j_r);                     % New reduced matrix

% --------- Extract mean values from block matrix --------- %
for i = 1:i_r
    for j = 1:j_r
        A_reduced(i, j) = mean( mean( u( 1+m_r*(i-1):m_r*i, 1+n_r*(j-1):n_r*j )));
    end
end
