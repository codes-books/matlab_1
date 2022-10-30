%利用函数trapmf建立梯形型隶属度函数
clear all
clc
x=0:0.1:10;
y=trapmf(x,[1 5 7 8]);
plot(x,y)
xlabel('函数输入值')
ylabel('函数输出值')
grid on