%����gaussmf������˹�������Ⱥ���
clear all
clc
x = 0:0.1:10;
y = gaussmf(x,[2 5]);
plot(x,y)
xlabel('��������ֵ')
ylabel('�������ֵ')
grid on