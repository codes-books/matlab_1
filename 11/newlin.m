%ͨ�������������Ԥ��
clear all
clc
time=0:0.01:10;
T=sin(time*2*pi);
Q=length(T);
P=zeros(5,Q);%P�д洢�ź�T��ǰ5(�ɱ䣬������Ҫ����)��ֵ����Ϊ�������롣
P(1,2:Q)=T(1,1:(Q-1));
P(2,3:Q)=T(1,1:(Q-2));
P(3,4:Q)=T(1,1:(Q-3));
P(4,5:Q)=T(1,1:(Q-4));
P(5,6:Q)=T(1,1:(Q-5));
plot(time,T)%�����ź�T����
xlabel('ʱ��');
ylabel('Ŀ���ź�');
title('��Ԥ���ź�');
net=newlind(P,T);%����������������ֱ��������������
a=sim(net,P);%�������
figure(2)
subplot(1,2,1)
plot(time,a,time,T,'k:')
xlabel('ʱ��');
ylabel('����źź�Ŀ���ź�����');
title('����źź�Ŀ���ź�����');
e=T-a;
subplot(1,2,2)
plot(time,e)
hold on
plot([min(time) max(time)],[0 0],'k:')
hold off
xlabel('ʱ��');
ylabel('�������');
title('�������');