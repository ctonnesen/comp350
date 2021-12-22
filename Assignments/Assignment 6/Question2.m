clc
clear all
format long
func=@(x) (2/sqrt(pi))*exp(-x.^2);


evala = feval(func,0);
evalb = feval(func,1);
setGlobal(2)

[It,i] = recurse_trapezoid(func,0,1,1,1e-6,0);
Is = simpson(func,0,1,evala,evalb,1e-6,1,100);

disp('Trapezoid');
disp('Number of evaluations');
disp(i);
disp('Final result is');
disp(It);
disp('Error is');
disp(erf(1)-It)

fprintf("\n \n");

disp('Simpson');
disp('Number of evaluations');
disp(getGlobal);
disp('Final result is');
disp(Is);
disp('Error is');
disp(erf(1)-Is)

function [It,i] = recurse_trapezoid(func,a,b,n,delta,it1)
    h = (a+b)/2.^n;
    sum = 0;
    for i = 1:2.^(n-1)
        sum = sum + feval(func,a+(2*i-1)*h);
    end
    it2 = 0.5*it1+h*sum;
    if abs(it2-it1)<= delta
        It = it2;
        return
    end
    [It,j] = recurse_trapezoid(func,a,b,n+1,delta,it2);
    i=i+j;
end


function [Is,eval_num] = simpson(func,a,b,evala,evalb,delta,level,level_max)
    setGlobal(getGlobal+3);
    h = b-a;
    c = (a+b)/2;
    evalc = feval(func,c);
    I1 = h*(evala+4*evalc+evalb)/6;
    level = level+1;
    d = (a+c)/2;
    e = (c+b)/2;
    I2 = h*(evala+4*feval(func,d)+2*evalc+4*feval(func,e)+evalb)/12;
    if level_max <= level
        Is = I2;
    else
        if abs(I2-I1) <= 15*delta
            Is = I2+1/15*(I2-I1);
        else
            Is = simpson(func,a,c,evala,evalc,delta/2,level,level_max) + simpson(func,c,b,evalc,evalb,delta/2,level,level_max);
        end
    end
end

function setGlobal(val)
    global evals
    evals = val;
end

function r = getGlobal
    global evals;
    r = evals;
end