function y=natureFunc(x)
y=0;
for i=1:5
    y=y+(i-1)/((x(i)+1)^2)
end
y=1/(0.3+y)
