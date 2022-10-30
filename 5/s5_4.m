%建立一般的钟型隶属度函数gbellmf
clear all
clc
x = 0:0.1:10;
y = gbellmf(x,[2 4 6]);
plot(x,y)
xlabel('函数输入值')
ylabel('函数输出值')
grid on