clear all
clc
load('trainData.mat')
trainData=[X Y];
in_format=genfis1(trainData);
[format1,error1,stepsize]=anfis(trainData,in_format,50);
y1=evalfis(X,format1)%��ѵ����������
y2=evalfis([41 13 11 789 3935],format1)%��������������
plot(1:10,Y,'b--',1:10,y1,'k.')
legend('Y:ѵ������','y1:��֤����' );   
xlabel('�������'),
ylabel('ϵͳ���')  