%%��ʼ���֣���ȡͼ�񼰼��������Ϣ
clear;
close all;
clc;
%format long;
t0=clock;
I=imread('Lenna.bmp');
threshold_opt=graythresh(I);
I1=im2bw(I,96/256);
figure(1);
imshow(I);
title('Դͼ');
figure(2);
imshow(I1);
title('��ֵ�ָ���ͼ��');
threshold_opt*255

t1=clock;
search_time=etime(t1,t0);
search_time