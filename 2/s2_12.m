%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%建立神经网络%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
% 设定样本数据
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
 
%转置后符合神经网络的输入格式
P=P';
 
%newsom建立SOM网络,竞争层为6*7=42个神经元
net=newsom(minmax(P),[6 7]);
plotsom(net.layers{1}.positions)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%建立好神经网络后，分别设定8种训练的步数%%%%%%%%%
%8次训练的步数
a=[5 20 40 80 160 320 640 1280];
% 随机初始化一个向量
yc=rands(9,9);
 
% 训练步数为5
net.trainparam.epochs=a(1);
%训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(1,:)=vec2ind(y);
figure(1)
subplot(2,2,1); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% 训练步数为20
net.trainparam.epochs=a(2);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(2,:)=vec2ind(y);
subplot(2,2,2); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% 训练步数为40
net.trainparam.epochs=a(3);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(3,:)=vec2ind(y);
subplot(2,2,3); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% 训练步数为80
net.trainparam.epochs=a(4);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(4,:)=vec2ind(y);
subplot(2,2,4); 
plotsom(net.IW{1,1},net.layers{1}.distances)

% 训练步数为160
net.trainparam.epochs=a(5);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(5,:)=vec2ind(y);
subplot(2,2,1); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% 训练步数为320
net.trainparam.epochs=a(6);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(6,:)=vec2ind(y);
subplot(2,2,2); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% 训练步数为640
net.trainparam.epochs=a(7);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(7,:)=vec2ind(y);
subplot(2,2,3); 
plotsom(net.IW{1,1},net.layers{1}.distances)
 
% 训练步数为1280
net.trainparam.epochs=a(8);
% 训练网络和查看分类
net=train(net,P);
%仿真网络
y=sim(net,P);
yc(8,:)=vec2ind(y);
subplot(2,2,4); 
plotsom(net.IW{1,1},net.layers{1}.distances)
