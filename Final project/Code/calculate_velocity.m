% -------------------- Description --------------------- %
%                                                        %
%            Update velocity values on the wall          %
%                                                        %
% ---------------------- Content ----------------------- %

[inner_field, interp_n] = deal(1, 10);

[u_n, v_n] = deal(u, v);            % Save [u_n, v_n] for convergence calc.
for i = Range(1, round(L/dx) + 1 )
    for j = Range(1, round((6*L/20)/dy + 1))
        if ( check_if_inside_field(i, j, inner_field) )
            u(i,j) = (psi(i, j+1) - psi(i, j-1))/(2*dy);
            v(i,j) = (psi(i-1, j) - psi(i+1, j))/(2*dx);
        else
            if( j == round((6*L/20)/dy + 1) && i > round((L/10)/dx + 1) )
                % ------- interpolate boundary    edges --------- %
                if (i > round((L/10)/dx + 1) )
                    u(i, j) = interp1(j-interp_n:(j-1), u(i, j-interp_n:(j-1)), j, 'linear', 'extrap');
                end
                % ------- interpolate singularity points ------- %
                if(i == round(L/dx) )
                    u(i, j) = ( sum(u(i-1:i+1, j-2:j), 'all')-u(i, j))/9;
                end
            end
        end
    end
end