%函数gaussmf建立高斯型隶属度函数
clear all
clc
x = 0:0.1:10;
y = gaussmf(x,[2 5]);
plot(x,y)
xlabel('函数输入值')
ylabel('函数输出值')
grid on