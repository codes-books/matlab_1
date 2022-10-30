%利用函数smf建立S型隶属度函数
clear all
clc
x=0:0.1:10;
y=smf(x,[1 8]);
plot(x,y)
xlabel('函数输入值')
ylabel('函数输出值')
grid on