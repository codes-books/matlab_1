%通用线性网络进行预测
clear all
clc
time=0:0.01:10;
T=sin(time*2*pi);
Q=length(T);
P=zeros(5,Q);%P中存储信号T的前5(可变，根据需要而定)次值，作为网络输入。
P(1,2:Q)=T(1,1:(Q-1));
P(2,3:Q)=T(1,1:(Q-2));
P(3,4:Q)=T(1,1:(Q-3));
P(4,5:Q)=T(1,1:(Q-4));
P(5,6:Q)=T(1,1:(Q-5));
plot(time,T)%绘制信号T曲线
xlabel('时间');
ylabel('目标信号');
title('待预测信号');
net=newlind(P,T);%根据输入和期望输出直接生成线性网络
a=sim(net,P);%网络测试
figure(2)
subplot(1,2,1)
plot(time,a,time,T,'k:')
xlabel('时间');
ylabel('输出信号和目标信号曲线');
title('输出信号和目标信号曲线');
e=T-a;
subplot(1,2,2)
plot(time,e)
hold on
plot([min(time) max(time)],[0 0],'k:')
hold off
xlabel('时间');
ylabel('误差曲线');
title('误差曲线');