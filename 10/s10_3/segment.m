function [ bw ] = segment( net,img )
%segment ����ѵ���õ���������зָ�ͼ��
%  net - �Ѿ�ѵ���õ�������
%  img - �ȷָ��ͼ��
%��� bw - �ָ��Ķ�ֵͼ��
[m n] = size(img);
P = img(:) ;
P = double(P);
P = P' ;
T = sim(net,P);
T(T<0.5) = 0 ;
T(T>0.5) = 255 ;
t = uint8(T);
t = t';
 bw = reshape(t,m,n);