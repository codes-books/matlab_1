clear all
clc
%�������3�е�Ŀ������
T = [-1 1; 1 -1;-1 -1];

%���������ȶ����Hopfield�������ȶ��ռ�ͼ��
axis([-1 1 -1 1 -1 1])
set(gca,'box','on'); axis manual;  hold on;
plot3(T(1,:),T(2,:),T(3,:),'r*')
title('Hopfield Network State Space')
xlabel('a(1)');
ylabel('a(2)');
zlabel('a(3)');
view([37.5 30]);

%����newhop����Hopfield������
net = newhop(T);
 
% ���������ʼ��
a = {rands(3,1)};
%Hopfield��������趨
[y,Pf,Af] = net({1 10},{},a);

%���ȶ��ռ����趨һ����ĵ�
record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot3(start(1,1),start(2,1),start(3,1),'bx', ...
   record(1,:),record(2,:),record(3,:))

%�ظ�ģ��20����ʼ����
color = 'rgbmy';
for i=1:20
   a = {rands(3,1)};
   [y,Pf,Af] = net({1 10},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot3(start(1,1),start(2,1),start(3,1),'kx', ...
      record(1,:),record(2,:),record(3,:),color(rem(i,5)+1))
end

%ʹ������P��ÿһ�з���Hopfield������
P = [ 1  -1  -0.5  1  1 ; ...
      0   0   0  0  0; ...
     -1   1   0.5  -1  -1];
cla
plot3(T(1,:),T(2,:),T(3,:),'r*')
color = 'rgbmy';
for i=1:5
   a = {P(:,i)};
   [y,Pf,Af] = net({1 10},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot3(start(1,1),start(2,1),start(3,1),'kx', ...
      record(1,:),record(2,:),record(3,:),color(rem(i,5)+1))
end
