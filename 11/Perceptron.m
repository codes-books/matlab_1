%��֪��ͨ�ó���
clear all
clc
P=[-5 -10 30 20 10;-5 0 -1 10 15];%��������
T=[1 1 0 0 0];%�������
plotpv(P,T);%��������ͼ��
xlabel('����1');
ylabel('����2');
title('��֪������ͼ');
net=newp([-40 1;-1 50],1);%�������磬���в����ֱ�Ϊ���������ķ�Χ����Ԫ��Ӧ������
hold on
linehandle=plotpc(net.iw{1},net.b{1});
net.adaptparam.passes=3; %��ʾ����
for a=1:30  %ѵ������
[net,Y,E]=adapt(net,P,T);
linehandle=plotpc(net.iw{1},net.b{1},linehandle);
drawnow;
end
