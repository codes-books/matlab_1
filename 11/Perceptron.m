%感知器通用程序
clear all
clc
P=[-5 -10 30 20 10;-5 0 -1 10 15];%输入向量
T=[1 1 0 0 0];%期望输出
plotpv(P,T);%描绘输入点图像
xlabel('坐标1');
ylabel('坐标2');
title('感知器分类图');
net=newp([-40 1;-1 50],1);%生成网络，其中参数分别为输入向量的范围和神经元感应器数量
hold on
linehandle=plotpc(net.iw{1},net.b{1});
net.adaptparam.passes=3; %显示步数
for a=1:30  %训练次数
[net,Y,E]=adapt(net,P,T);
linehandle=plotpc(net.iw{1},net.b{1},linehandle);
drawnow;
end
