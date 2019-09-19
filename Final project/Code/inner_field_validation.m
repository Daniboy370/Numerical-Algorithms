close all;

[a, b] = size(psi);
Mat_check = zeros(a, b);

for i = 1:a
    for j = 1:b
        if check_if_inside_field(i, j, 0)
            Mat_check(i, j) = 1;
        end
    end
end

figure; surf(Mat_check'); alpha(0.65); view([-32 64]);
