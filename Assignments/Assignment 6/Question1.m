clc
clear all

format long
f=@(x) (2/sqrt(pi))*exp(-x.^2);
n=2;
I=0;
while(true)
    I=trapezoid(f,0,2,n);
    check=erf(2)-I;
    if(abs(erf(2)-I)<=1e-6)
        break;
    end
    n=n+1;
end
disp('Number of evaluations');
disp(n-1);
disp('Number of points needed are');
disp(n+1);
disp('Error is');
disp(erf(2)-I)


function I = trapezoid(func,a,b,n)
% I = trap(func,a,b,n):
% multiple-application trapezoidal rule.
% input:
% func = name of function to be integrated
% a, b = integration limits
% n = number of segments
% output:
% I = integral estimate
    inner_h = feval(func,a) + feval(func,b);
    h = (b - a)/n;
    sum = 0;
    for i = 1:n-1
        sum = sum + feval(func,a+i*h);
    end
    I = 0.5*h*inner_h+h*sum;
end