%����һ������������Ⱥ���gbellmf
clear all
clc
x = 0:0.1:10;
y = gbellmf(x,[2 4 6]);
plot(x,y)
xlabel('��������ֵ')
ylabel('�������ֵ')
grid on