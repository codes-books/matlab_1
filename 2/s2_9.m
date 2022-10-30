clear all
clc
%%%%%%%%%%设置网络输入值和目标值%%%%%%%%%%
k=2;
p=[-1:.05:8];
t=1+sin(k*pi/2*p);
plot(p,t,'-');
title('要逼近的非线性函数');
xlabel('时间');
ylabel('非线性函数');
%%%%%%%%%%建立网络%%%%%%%%%%
n=5;
net = newff(minmax(p),[n,1],{'tansig' 'purelin'},'trainlm');
%对于初始网络，可以应用sim（）函数观察网络输出。
y1=sim(net,p);
figure;
plot(p,t,'-',p,y1,':')
title('未训练网络的输出结果');
xlabel('时间');
ylabel('仿真输出--原函数-');
%%%%%%%%%%设置训练网络参数%%%%%%%%%%
net.trainParam.epochs=200;  	%网络训练时间设置为200
net.trainParam.goal=0.2;  		%网络训练精度设置为0.2
net=train(net,p,t);        		%开始训练网络;
%%%%%%%%%%仿真网络%%%%%%%%%%
% y2=sim(net,p);
% figure;
% plot(p,t,'-',p,y1,':',p,y2, '--')
% title('训练后网络的输出结果');
% xlabel('时间');
% ylabel('仿真输出');

