clc;
f = @(x) x^3-2*x-5;
fd = @(x) 3*x^2-2;
fplot(f, [-5 5])
ylim([-10 10])

secant_calc(f, 2 ,3 ,1.e-12, 1.e-12, 100000);
newton(f, fd ,2,1.e-12,1.e-12,100000);
bisect(f, 2, 3, 1.e-12);

function r = secant_calc(f, x0, x1, xtol, ftol, nmax)
    disp('Secant Method:')
    ITERATIONS = zeros(7,4);
    ITERATIONS(1,:) = [0,x1-x0,x0,x1];
    fx0 = f(x0);
    fx1 = f(x1);
    for n = 1 : nmax
        d = fx1*(x1 - x0)/(fx1-fx0);
        x0 = x1;
        fx0 = fx1;
        x1 = x1 - d;
        fx1 = f(x1);
        ITERATIONS(n+1,:) = [n, d, x0, x1,];
        if abs(d) <= xtol || abs(fx1) <= ftol
            r = x1;
            disp(array2table(ITERATIONS,"VariableNames",["n","d","x0","x1"],"RowNames",["Start","Loop 1","Loop 2","Loop 3","Loop 4","Loop 5","Loop 6"]));
            return
        end
    end
    r = x1;
end

function r = newton(f, fd, x, xtol, ftol, nmax)
    disp('Newton Method:')
    ITERATIONS = zeros(5,3);
    ITERATIONS(1,:) = [0,0,x];
    for n = 1 : nmax
        d = f(x)/fd(x);
        x = x-d;
        ITERATIONS(n+1,:) = [n, abs(d), x];
        if abs(d) <= xtol || f(x) <= ftol
            r = x;
            disp(array2table(ITERATIONS,"VariableNames",["n","d","x"],"RowNames",["Start","Loop 1","Loop 2","Loop 3","Loop 4"]));
            return
        end
    end
    r = x1;
end   

function r = bisect(f, a, b, delta)
    c = (a+b)/2;
    error = abs(b-a)/2;
    counter = 2;
    ROW = strings(1,40);
    ROW(1,1) = "Start";
    disp('Bisection Method:')
    ITERATIONS = zeros(10,4);
    ITERATIONS(1,:) = [a, b, c, error,];
    while error > delta
        if f(c) == 0
            r = c;
            return
        end
        if f(a)*f(c) < 0
            b = c;
        else
            a = c;
        end
        c = (a+b)/2;
        error = error/2;
        ITERATIONS(counter,:) = [a, b, c, error];
        ROW(1,counter) = ["Loop "+(counter-1)];
        counter = counter + 1;
    end
    r = c;
    disp(array2table(ITERATIONS,"VariableNames",["a","b","c", "error"],"RowNames",ROW));
end 

