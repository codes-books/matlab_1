%利用mae函数求解一个神经网络的平均绝对误差
clear all
clc
net = perceptron;
net = configure(net,0,0);
p = [-10 -5 0 5 10];
t = [0 0 1 1 1];
y = net(p);
e = t-y;
perf = mae(e)
