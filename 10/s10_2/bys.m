%���ڱ�Ҷ˹�����㷨��ͼ����ֵ�ָ� 
clear 
clc; 
Init = imread('1.jpg'); 
% Im=imhist(Init);
Im=rgb2gray(Init); 
subplot(1,3,1),
imhist(Im) 
title('ֱ��ͼ')
subplot(1,3,2),
imshow(Im) 
title('�ָ�ǰԭʼͼ')

[x,y]=size(Im);                    % ���ͼ���С 
b=double(Im);                   
zd=double(max(Im))                  % ���ͼ�������ĻҶ� 
zx=double(min(Im))                % ��С�ĻҶ�  
T=double((zd+zx))/2;                     % T����ֵ��Ϊ���ֵ����Сֵ��ƽ��ֵ 

count=double(0);                         % ��¼����ѭ�� 
while 1                   % ���������ֵ�ָ��㷨 
    count=count+1; 
    S0=0.0; n0=0.0;                   %Ϊ����Ҷȴ�����ֵ��Ԫ�صĻҶ���ֵ��������ֵ 
    S1=0.0; n1=0.0;                   %Ϊ����Ҷ�С����ֵ��Ԫ�صĻҶ���ֵ��������ֵ 
    for i=1:x
        for j=1:y
            if double(Im(i,j))>=T
                S1=S1+double(Im(i,j));  %��������ֵͼ���Ҷ�ֵ�ۼ�
                n1=n1+1;                %��������ֵͼ�������ۼ�
            else 
                S0=S0+double(Im(i,j));  %С������ֵͼ���Ҷ�ֵ�ۼ�
                n0=n0+1;                %С�ڷ���ֵͼ�������ۼ�
            end 
        end 
    end  
    T0=S0/n0; %��С�ڷ���ֵ��ֵ
    T1=S1/n1; %����ڷ���ֵ��ֵ
    if abs(T-((T0+T1)/2))<0.1       %������ ǰ�����η���ֵ����Ϊ0ʱ ֹͣ������
        break;
    else
       T=(T0+T1)/2;                 %����ֵT�£�������ֵ�ļ������ 
   end 
end 

count                                %��ʾ���д���
T
i1=im2bw(Im,T/255);                 % ͼ���������ֵ�¶�ֵ�� 
subplot(1,3,3),
imshow(i1) 
title('�ָ��ͼ��')
