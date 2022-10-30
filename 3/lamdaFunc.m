function y=lamdaFunc(x)
y=0;
for i=1:5
    y=y+(i+2)/(((x(i)-1)^2)+0.5);
end
y=1/(0.7+y);
