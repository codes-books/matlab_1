%建立双边高斯型隶属度函数gauss2mf
clear all
clc
x = [0:0.1:10]';
y1 = gauss2mf(x,[2 4 1 8]);
y2 = gauss2mf(x,[2 5 1 7]);
y3 = gauss2mf(x,[2 6 1 6]);
y4 = gauss2mf(x,[2 7 1 5]);
y5 = gauss2mf(x,[2 8 1 4]);
plot(x,[y1 y2 y3 y4 y5]);