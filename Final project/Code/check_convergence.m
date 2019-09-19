% -------------------------- Description -------------------------- %
%                                                                   %
%               Check convergence of all functions                  %
%    Process calculation proceeds as long as conv. not achieved     %
%                                                                   %
% --------------------------- Content ----------------------------- %


% ---------------- Extract maximal vorticity value ---------------- %
w_max = eps;                  % Initialize dummy value
for i = Range(2, M )
    for j = Range(2, N )
        if ( check_if_inside_field(i, j, inner_field) )
            if(abs( w(i,j)) > w_max)
                w_max = abs( w(i,j));
            end
        end
    end
end

% ---------------- Check all convergence status ------------------- %
conv_not_achieved = 0;
for i = Range(2, M)
    for j = Range(2, N)
        if ( check_if_inside_field(i, j, inner_field) )
            % conv_not_achieved = 1 == continuance of calculation
            % conv_not_achieved = 0 == convergence achieved
            if( ( abs(dt*dw_dt(i,j) )/w_max > epsilon) ) % || ( abs(u(i,j) - u_n(i,j))*.1 > epsilon ) || ( abs( v(i,j) - v_n(i,j))*.1 > epsilon) )
                conv_not_achieved = 1;
            end
        end
    end
end
