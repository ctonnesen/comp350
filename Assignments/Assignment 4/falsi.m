clc;
f = @(x) x^3-2*x-5;
fd = @(x) 3*x^2-2;
%fplot(f, [-5 5])
%ylim([-10 10])

falsi_calc(f, 2, 3, 1.e-12, 1.e-12);

function r = falsi_calc(f, a, b, xtol, ftol)
    c = b - (b-a)/(f(b)-f(a))*f(b);
    i = 1;
    disp('Falsi Method:')
    ITERATIONS = zeros(10,4);
    ITERATIONS(1,:) = [a, b, c, f(c),];
    ROW(1) = "Start";
    while abs(a-b) >= xtol && abs(f(c)) >= ftol
        c = b - ((b-a)/(f(b)-f(a)))*f(b);
        if f(b)*f(c) < 0
            b = c;
        else
            a = c;
        end
        i = i+1;
        ITERATIONS(i,:) = [a, b, c, f(c)];
        ROW(i) = "Loop "+(i-1);
    end
    r = c;
    disp(array2table(ITERATIONS,"VariableNames",["a","b","c", "f(c)"],"RowNames",ROW));
end