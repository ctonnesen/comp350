clc
t = (1900:10:2000);
y = [75.9950 91.9720 105.7110 123.2030 131.6690 150.6970 179.3230 203.2120 226.5050 249.6330 281.422];
z = findZ(size(t,2),t,y);
s = findSwX(1975,t,y,z,size(t,2));

scatter(t,y,'Color','b','Marker','o')
hold on
plot(1975,s,'Color','r','Marker','o')
for i = 1 : size(t,2)-1
    fplot(findSwoX(t,y,z,i),[t(i) t(i+1)], 'Color',"b");
    if i == 10
        fplot(findSwoX(t,y,z,i),[2000 2010], 'Color',"g")
        x = 2010;
        point = subs(findSwoX(t,y,z,i));
        plot(2010,point,'Color',"r",'Marker','o')
    end
end
hold off

function z = findZ(n,t,y)
    h=[];
    b=[];
    for i = 1 : n-1
        h(i) = t(i+1) - t(i);
        b(i) = (y(i+1) - y(i))/h(i);
    end
    % Forward elimination0
    u=[];
    v=[];
    u(1) = 2*(h(1) + h(2));
    v(1) = 6*(b(2) - b(1));
    for i = 2 : n-1
        mult = h(i-1)/u(i-1);
        u(i) = 2*(h(i-1)+ h(i)) - mult * h(i-1);
        v(i) = 6*(b(i) - b(i-1)) - mult * v(i-1);
    end
    % Back substitution
    z=[];
    z(n) = 0;
    z(1) = 0;
    for i = n-1 : -1 : 2
        z(i) = (v(i) - h(i)*z(i+1))/u(i);
    end
end


function s = findSwoX(t,y,z,i)
    syms x
     h = t(i+1) - t(i);
     B = -h*z(i+1)/6 - h*z(i)/3 + (y(i+1) - y(i))/h;
     D = (z(i+1) - z(i))/(6*h);
     s = y(i) + (x - t(i))*(B + (x - t(i))*(z(i)/2 + (x - t(i))*D));
end


function s = findSwX(x,t,y,z,n)
    upper = 0;
    lower = 0;
    for i = 1 : n - 1
        if x - t(i+1) <= 0
            lower = i;
            upper = i+1;
            break
        end
    end
    h = t(upper) - t(lower);
    B = -h*z(upper)/6 - h*z(lower)/3 + (y(upper) - y(lower))/h;
    D = (z(upper) - z(lower))/(6*h);
    s = y(lower) + (x - t(lower))*(B + (x - t(lower))*(z(lower)/2 + (x - t(lower))*D));
end



