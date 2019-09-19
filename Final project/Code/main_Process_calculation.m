% -------------------------- Description ------------------------- %
%                                                                  %
%                   Calculates values inside field                 %
%                                                                  %
% --------------------------- Content ---------------------------- %

while( conv_not_achieved == 1 )
    calculate_dw_dt;            % caculates vorticity derivative within field   
    w = w + dt*dw_dt;           % Euler method :: w_{n+1} = w_{n} + dt*dw_{n}
    calculate_stream;           % caculates stream   within field
    calculate_vorticity;        % caculates vorticity on the walls
    calculate_velocity;         % caculates velocity within field
    calculate_evolution;        % caculates evolution of shape's center
    check_convergence;          % Check convergence criteria
    i_step = i_step + 1;        % updates the iteration index
    t = t + dt;                 % updates time index
end
