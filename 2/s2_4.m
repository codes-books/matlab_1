clear all
clc
a=3;               %列数
b=3;               %行数
c=4;               %神经元个数
W=ones(c,b);
B=ones(c,a);
P=ones(b,a);
x=W*P+B;          %计算神经网络加权输入
A=logsig(x)       %计算神经网络输出
