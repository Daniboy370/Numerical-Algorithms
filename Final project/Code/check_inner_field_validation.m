% close all;
clear c;

c = zeros(M, N);

for i = 1:M
    for j = 1:N
        if check_if_inside_field(i, j, 0)
            c(i, j) = 1;
        end
    end
end

figure; surf(c'); alpha(0.65); view([-32 64]);