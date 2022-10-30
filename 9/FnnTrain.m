%模糊神经网络模式识别
clear all
clc
function retstr = FnnTrain(dt,ld,tt,sp) 
retstr=-1; 
%%%% 输入参数赋值开始 %%%%%%%%%%%%%%%%%%%%%%% 
% 方便调试程序用，程序调试时去掉这部分的注释 
dt=4;      %学习阈值 
ld=0.05;    %学习进度 
tt=10;      %训练次数 
% sp='data\sample.txt';    %一个点的监测数据 
sp=[1 2 3 4 5;
    2 4 5 1 8];
%%%% 输入参数赋值结束 %%%%%%%%%%%%%%%%%%%%%%%% 
global recordDimention; 
global sampleNumber; 
global weightNumber; 
global distanceThread; 
global WW; 
global learningDegree; 
global epochsNumber; 
distanceThread=dt; 
learningDegree=ld; 
traintimes=tt; 
A=load(sp); 
   
[Arow Acol]=size(A); 
%样本个数 
sampleNumber=Arow; 
recordDimention=Acol; 
disp(sampleNumber); 
WW=A(1,:); 
WW=[WW [1]]; 
weightNumber=1; 
epochsNumber=1; 
   
for jj=2:1:sampleNumber 
      TrainNN2(A(jj,:)); 
end 
for jt=1:traintimes-1 
      for jt2=1:sampleNumber 
          TrainNN2(A(jj,:)); 
      end 
end 
% 将训练结果写入权值文件 
dlmwrite('data\w.dat',WW,'\t'); 
% 
% 训练子函数 
% 
function TrainNN2(a) 
global recordDimention; 
global sampleNumber; 
global weightNumber; 
global distanceThread; 
global WW; 
global learningDegree; 
global epochsNumber; 

Ldistance=zeros(2,weightNumber); 
for j1=1:weightNumber 
      Ldistance(2,j1)=j1; 
end 
% %%%%%输入输出空间的模糊分割 
for j2=1:weightNumber 
      Lx=0; 
      for j3=1:recordDimention 
          Lx=Lx + (a(j3) - WW(j2,j3)) .* (a(j3) - WW(j2,j3)); 
      end 
      Ldistance(1,j2)=sqrt(Lx); 
end 
% %%%%%计算模糊空间的距离   
Lx1=Ldistance(1,1); 
Lx2=Ldistance(2,1); 
for j4=2:weightNumber 
      if(Ldistance(1,j4)<Lx1) 
          Lx1=Ldistance(1,j4); 
          Lx2=Ldistance(2,j4); 
      end 
end 
% %%%%%修正模糊规则 
updateW=0; 
nowWeight=Lx2; 
if(Lx1<=distanceThread) 
      for j6=1:recordDimention 
          WW(nowWeight,j6)=WW(nowWeight,j6) + learningDegree .* (a(j6) - WW(nowWeight,j6)); 
      end 
      WW(nowWeight,recordDimention+1)=WW(nowWeight,recordDimention+1)+1; 
      updateW=1; 
end 
     
if( updateW==0) 
      weightNumber=weightNumber+1; 
      a=[a [1]]; 
      WW=[WW;a]; 
end

