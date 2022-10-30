%建立pi型隶属度函数pimf
clear all
clc
x=0:0.1:10;
y=pimf(x,[1 4 5 10]);
plot(x,y)
xlabel('函数输入值')
ylabel('函数输出值')
grid on