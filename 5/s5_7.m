%用函数trimf建立三角型隶属度函数
clear all
clc
x=0:0.1:10;
y=trimf(x,[3 6 8]);
plot(x,y)
xlabel('函数输入值')
ylabel('函数输出值')
grid on