clear all
clc
a=3;               %����
b=3;               %����
c=4;               %��Ԫ����
W=ones(c,b);
B=ones(c,a);
P=ones(b,a);
x=W*P+B;          %�����������Ȩ����
A=logsig(x)       %�������������
