clear all
clc
%���ڲ��������ļ�
generatesample('sample.mat');  
%�Ŵ�������ѵ��ʾ��
gaP = [100 0.00001];
bpP = [500 0.00001];
load('sample.mat');
gabptrain( gaP,bpP,p,t )
%������ָ�ʾ��
load('net.mat');%�Ѿ�ѵ���õ�������
img = imread('a.bmp');%�ȷָ��ͼ��
bw = segment( net,img ) ;%�ָ��Ķ�ֵͼ��
figure;
subplot(1,2,1);
imshow(img);
title('�ָ�ǰ��ֵͼ��Ա�ͼ')
subplot(1,2,2);
imshow(bw);
title('�ָ���ֵͼ��Ա�ͼ')
%��ͳBPѵ��
epochs = 200;
goal = 0.0001 ;
net = newcf([0 255],[7 1],{'tansig' 'purelin'});
net.trainParam.epochs = epochs;
net.trainParam.goal = goal ;
load('sample.mat');
net = train(net,p,t);
%�Ŵ�BPѵ��
%�Ŵ��㷨Ѱ������Ȩֵ��ֵ����һЩʱ�䣬
gaP = [100 0.00001];
bpP = [500 0.00001];
gabptrain( gaP,bpP,p,t );