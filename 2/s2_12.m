%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%����������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
% �趨��������
m=9;
n=8;
P=rand(m,n);
for i=1:m
    for j=1:n
        if P(i,j)>0.7
            P(i,j)=1;
        else
            P(i,j)=0;
        end
    end
end
 
%ת�ú����������������ʽ
P=P';
 
%newsom����SOM����,������Ϊ6*7=42����Ԫ
net=newsom(minmax(P),[6 7]);
plotsom(net.layers{1}.positions)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%������������󣬷ֱ��趨8��ѵ���Ĳ���%%%%%%%%%
%8��ѵ���Ĳ���
a=[5 20 40 80 160 320 640 1280];
% �����ʼ��һ������
yc=rands(9,9);
 
% ѵ������Ϊ5
net.trainparam.epochs=a(1);
%ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(1,:)=vec2ind(y);
figure(1)
subplot(2,2,1); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% ѵ������Ϊ20
net.trainparam.epochs=a(2);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(2,:)=vec2ind(y);
subplot(2,2,2); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% ѵ������Ϊ40
net.trainparam.epochs=a(3);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(3,:)=vec2ind(y);
subplot(2,2,3); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% ѵ������Ϊ80
net.trainparam.epochs=a(4);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(4,:)=vec2ind(y);
subplot(2,2,4); 
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ160
net.trainparam.epochs=a(5);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(5,:)=vec2ind(y);
subplot(2,2,1); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% ѵ������Ϊ320
net.trainparam.epochs=a(6);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(6,:)=vec2ind(y);
subplot(2,2,2); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% ѵ������Ϊ640
net.trainparam.epochs=a(7);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(7,:)=vec2ind(y);
subplot(2,2,3); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% ѵ������Ϊ1280
net.trainparam.epochs=a(8);
% ѵ������Ͳ鿴����
net=train(net,P);
%��������
y=sim(net,P);
yc(8,:)=vec2ind(y);
subplot(2,2,4); 
plotsom(net.IW{1,1},net.layers{1}.distances)
