%基于贝叶斯分类算法的图像阈值分割 
clear 
clc; 
Init = imread('1.jpg'); 
% Im=imhist(Init);
Im=rgb2gray(Init); 
subplot(1,3,1),
imhist(Im) 
title('直方图')
subplot(1,3,2),
imshow(Im) 
title('分割前原始图')

[x,y]=size(Im);                    % 求出图象大小 
b=double(Im);                   
zd=double(max(Im))                  % 求出图象中最大的灰度 
zx=double(min(Im))                % 最小的灰度  
T=double((zd+zx))/2;                     % T赋初值，为最大值和最小值的平均值 

count=double(0);                         % 记录几次循环 
while 1                   % 迭代最佳阈值分割算法 
    count=count+1; 
    S0=0.0; n0=0.0;                   %为计算灰度大于阈值的元素的灰度总值、个数赋值 
    S1=0.0; n1=0.0;                   %为计算灰度小于阈值的元素的灰度总值、个数赋值 
    for i=1:x
        for j=1:y
            if double(Im(i,j))>=T
                S1=S1+double(Im(i,j));  %大于阈域值图像点灰度值累加
                n1=n1+1;                %大于阈域值图像点个数累加
            else 
                S0=S0+double(Im(i,j));  %小于阈域值图像点灰度值累加
                n0=n0+1;                %小于阀域值图像点个数累加
            end 
        end 
    end  
    T0=S0/n0; %求小于阀域值均值
    T1=S1/n1; %求大于阀域值均值
    if abs(T-((T0+T1)/2))<0.1       %迭代至 前后两次阀域值相差几乎为0时 停止迭代。
        break;
    else
       T=(T0+T1)/2;                 %在阈值T下，迭代阈值的计算过程 
   end 
end 

count                                %显示运行次数
T
i1=im2bw(Im,T/255);                 % 图像在最佳阈值下二值化 
subplot(1,3,3),
imshow(i1) 
title('分割后图形')
