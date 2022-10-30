%ģ��������ģʽʶ��
clear all
clc
function retstr = FnnTrain(dt,ld,tt,sp) 
retstr=-1; 
%%%% ���������ֵ��ʼ %%%%%%%%%%%%%%%%%%%%%%% 
% ������Գ����ã��������ʱȥ���ⲿ�ֵ�ע�� 
dt=4;      %ѧϰ��ֵ 
ld=0.05;    %ѧϰ���� 
tt=10;      %ѵ������ 
% sp='data\sample.txt';    %һ����ļ������ 
sp=[1 2 3 4 5;
    2 4 5 1 8];
%%%% ���������ֵ���� %%%%%%%%%%%%%%%%%%%%%%%% 
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
%�������� 
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
% ��ѵ�����д��Ȩֵ�ļ� 
dlmwrite('data\w.dat',WW,'\t'); 
% 
% ѵ���Ӻ��� 
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
% %%%%%��������ռ��ģ���ָ� 
for j2=1:weightNumber 
      Lx=0; 
      for j3=1:recordDimention 
          Lx=Lx + (a(j3) - WW(j2,j3)) .* (a(j3) - WW(j2,j3)); 
      end 
      Ldistance(1,j2)=sqrt(Lx); 
end 
% %%%%%����ģ���ռ�ľ���   
Lx1=Ldistance(1,1); 
Lx2=Ldistance(2,1); 
for j4=2:weightNumber 
      if(Ldistance(1,j4)<Lx1) 
          Lx1=Ldistance(1,j4); 
          Lx2=Ldistance(2,j4); 
      end 
end 
% %%%%%����ģ������ 
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

