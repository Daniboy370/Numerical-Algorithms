% -------------------- Description --------------------- %
%                                                        %
%            Calculate stream using GS method            %
%                                                        %
% ---------------------- Content ----------------------- %

[inner_field, psi_flag] = deal(1, 1);         % Initialize

% ------------ GS with iterative fixed point ----------- %
while ( psi_flag == 1 )
    m = 1;
    for i = Range(2, (L/dx))
        for j = Range(2, (H/dy))
            if ( check_if_inside_field(i, j, inner_field) )    % Ensure computation is within the field
                psi_m = psi(i,j);
                psi(i, j) = ( (dy^2)*(psi((i+1),j) + psi((i-1),j) ) + ((dx^2)*(psi(i,(j+1)) + psi(i,(j-1)))) - ...
                    ((dy^2)*(dx^2)*w(i, j)))/(2*((dx^2)+(dy^2)) );
                % ------- SOR method ------- %
                psi(i, j) = psi_m + Omega*(psi(i,j) - psi_m);  % S.O.R
                psi_diff(m) = abs(psi(i,j) - psi_m);           % psi convergeance criterion
                m = m+1;                     % increment
            end
        end
    end
    psi_flag = 0;
    % ------------------- Check stream convergence -------------------- %
    if( ( max(psi_diff) > epsilon ) || (psi_flag == 1) )
        psi_flag = 1;
    else
        psi_flag = 0;
    end
    clear d;
end
