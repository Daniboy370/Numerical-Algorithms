function u = Thomas_Algorithm(A, D)
% ------------------- Description ------------------- %
%
% Thomas algorithm for an efficient costly computation of
% y vector out of algraic system : y = L_s^(-1)*(b - U*y_N(1, :)')
% Whereas : Lower = tril(A); Upper = triu(A,1);
%
% -------------------- Algorithm -------------------- %
N = length(D);
u = zeros(N,1); delta = u; beta = u; a = u; c = u;
[a(2:N), b, c(1:N-1)] = deal(diag(A, -1), diag(A, 0), diag(A, 1));

beta(1) = A(1,1); delta(1) = D(1);
% a = tril(A,1); b = diag(A); c = triu(A);

% ----- Define variables for Gauss Elimination ------ %
for i = 2:N
    beta(i)  = b(i) - a(i)*    c(i-1) /beta(i-1);
    delta(i) = D(i) - a(i)*delta(i-1) /beta(i-1);
end

% --------------- Extract u (y) vector -------------- %
u(end) = delta(end)/beta(end);
for i = (N-1):-1:1
    u(i) = ( delta(i) - c(i)*u(i+1) ) /beta(i);
end
