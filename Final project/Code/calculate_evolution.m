% -------------------- Description --------------------- %
%                                                        %
%        Calculate shape center points evolution         %
%                                                        %
% ---------------------- Content ----------------------- %

psi_ss(i_step) = psi(evolution_x, evolution_y);   % stream     point along time
w_ss(i_step)   = w  (evolution_x, evolution_y);   % vorticity  point along time
u_ss(i_step)   = u  (evolution_x, evolution_y);   % u velocity point along time
v_ss(i_step)   = v  (evolution_x, evolution_y);   % v velocity point along time
