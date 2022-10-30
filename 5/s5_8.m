%建立梯形型隶属度函数zmf
clear all
clc
x=0:0.1:10;
y=zmf(x,[3 7]);
plot(x,y)
xlabel('函数输入值')
ylabel('函数输出值')
grid on