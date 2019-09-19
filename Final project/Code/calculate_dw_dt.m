% -------------------- Description --------------------- %
%                                                        %
%            Update velocity values on the wall          %
%                                                        %
% ---------------------- Content ----------------------- %
inner_field = 1;
for i = Range(2, M )
    for j = Range(2, M )
        if check_if_inside_field(i, j, inner_field)  % Ensure computation is within the field
            if( (u(i, j) >= 0) && ( v(i,j) >= 0) )
                dw_dt(i, j) = (((dx^2)*w(i,j+1))+( w(i,j-1)*(( v(i,j)*(dx^2)*dy*Re)+(dx^2)))+( w(i+1,j)*(dy^2))+ ...
                    +( w(i-1,j)*((u(i,j)*dx*(dy^2)*Re)+(dy^2)))) - (((2)*(dy^2))+((2)*(dx^2))+v(i,j)*(dx^2)*dy*Re+u(i,j)*(dy^2)*dx*Re)*w(i,j);
            end
            if( (u(i, j) <  0)  && ( v(i,j) <  0) )
                dw_dt(i, j) = (((dx^2)*w(i,j-1))+( w(i,j+1)*((dx^2)-( v(i,j)*(dx^2)*dy*Re)))+( w(i-1,j)*(dy^2))+ ...
                    +( w(i+1,j)*((dy^2)-(u(i,j)*dx*(dy^2)*Re)))) - (((2)*(dy^2))+((2)*(dx^2))-v(i,j)*(dx^2)*dy*Re-u(i,j)*(dy^2)*dx*Re)*w(i,j);
            end
            if( (u(i, j) >= 0)  && ( v(i,j) <  0) )
                dw_dt(i, j) = (((dx^2)*w(i,j-1))+( w(i,j+1)*((dx^2)-( v(i,j)*(dx^2)*dy*Re)))+( w(i+1,j)*(dy^2))+ ...
                    +( w(i-1,j)*((dy^2)+(u(i,j)*dx*(dy^2)*Re)))) - (((2)*(dy^2))+((2)*(dx^2))-v(i,j)*(dx^2)*dy*Re+u(i,j)*(dy^2)*dx*Re)*w(i,j);
            end
            if( (u(i, j) <  0)  && ( v(i,j) >= 0) )
                dw_dt(i, j) = (((dx^2)*w(i,j+1))+( w(i,j-1)*((dx^2) + ( v(i,j)*(dx^2)*dy*Re)))+( w(i-1,j)*(dy^2))+ ...
                    +( w(i+1,j)*((dy^2)-(u(i,j)*dx*(dy^2)*Re)))) - (((2)*(dy^2))+((2)*(dx^2))+v(i,j)*(dx^2)*dy*Re-u(i,j)*(dy^2)*dx*Re)*w(i,j);
            end
        end
    end
end