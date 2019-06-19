function y = Matlab_solution(x, Eqn, y0, yf)
res = @(ya, yb)[ ya(1) - y0; yb(1) - yf];       % B.V. -- y(0), y(f)
solinit = bvpinit(x, [1 1]);                    % Initial guess vector > 0
sol = bvp4c(Eqn, res, solinit);
y = deval(sol, x);