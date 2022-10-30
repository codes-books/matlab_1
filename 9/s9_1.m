clear all
clc
load('trainData.mat')
trainData=[X Y];
in_format=genfis1(trainData);
[format1,error1,stepsize]=anfis(trainData,in_format,50);
y1=evalfis(X,format1)%用训练样本仿真
y2=evalfis([41 13 11 789 3935],format1)%用评价样本仿真
plot(1:10,Y,'b--',1:10,y1,'k.')
legend('Y:训练样本','y1:验证样本' );   
xlabel('样本序号'),
ylabel('系统输出')  