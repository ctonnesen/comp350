clc
x = (1900:10:2000);
y = [75.9950 91.9720 105.7110 123.2030 131.6690 150.6970 179.3230 203.2120 226.5050 249.6330 281.422];

scatter(x,y,'Color','b','Marker','o')
c0 = c0Calc(x,y);
c1 = c1Calc(x,y);
syms b
hold on
f(b) = c0+c1*b;
fplot(f(b),[1900 2010])
plot(1975,f(1975),'Color','r','Marker','o')
plot(2010,f(2010),'Color','r','Marker','o')
hold off

function c0 = c0Calc(x,y)
    sqx = x.^2;
    top_lhs = sum(sqx)*sum(y);
    top_rhs = sum(x)*sum(x.*y);
    bottom = (size(x,2))*sum(sqx)-sum(x)^2;
    c0 = (top_lhs-top_rhs)/bottom;
end

function c1 = c1Calc(x,y)
    sqx = x.^2;
    top_lhs = (size(x,2))*sum(x.*y);
    top_rhs = sum(x)*sum(y);
    bottom = (size(x,2))*sum(sqx)-sum(x)^2;
    c1 = (top_lhs-top_rhs)/bottom;
end