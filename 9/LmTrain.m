% L-M神经网络算法之MATLAB实现1 
%此为BP网络训练程序  
function retstr = LmTrain(ModelNo,NetPara,TrainPara,InputFun,OutputFun,DataDir)  
NNTWARN OFF  
retstr=-1;  
%%%% 输入参数赋值开始 %%%%%%%%%%%%%%%%%%%%%%%  
% 方便调试程序用，程序调试时去掉这部分的注释  
ModelNo='1';  
NetPara(1)=7;  
NetPara(2)=1;  
NetPara(3)=6;  
NetPara(4)=10;  
TrainPara(1)=25;  
TrainPara(2)=1000;  
TrainPara(3)=0.001;  
TrainPara(4)=0.001;  
TrainPara(5)=0.001;  
TrainPara(6)=10;  
TrainPara(7)=0.1;  
TrainPara(8)=1e10;  
DataDir='.';  
InputFun = 'tansig';  
OutputFun = 'purelin';  
%%%% 输入参数赋值结束 %%%%%%%%%%%%%%%%%%%%%%%%  
%保留原目录  
olddir=pwd;  
%进入数据所在目录  
cd(DataDir);  
deltalin(1);  
deltalog(1);  
deltatan(1);  
% 网络参数  
InputDim=NetPara(1);      %输入层节点数  
OutputDim=NetPara(2);      %输出层节点数  
MidDim=NetPara(3);        %中间层节点数  
data_num=NetPara(4);      %训练数据组数  
% 网络训练参数  
if (TrainPara == -1)  
    df = 25;              %显示间隔次数 25  
    me = 1000;            %最大循环次数 1000  
    eg = 0.001;            %目标误差 0.02  
    lr = 0.001;            %学习速率 0.001  
    lr_inc = 0.001;        %学习速率增加比率 0.001  
    lr_idec = 10;          %学习速率减少比率 10  
    mom_const = 0.1;      %动量常数 0.1  
    err_ratio = 1e10;      %最大误差比率 1e10  
else  
    df=TrainPara(1);            %显示间隔次数 25  
    me=TrainPara(2);            %最大循环次数 1000  
    eg=TrainPara(3);            %目标误差 0.02  
    lr=TrainPara(4);            %学习速率 0.001  
    lr_inc=TrainPara(5);        %学习速率增加比率 0.001  
    lr_idec=TrainPara(6);      %学习速率减少比率 10  
    mom_const=TrainPara(7);    %动量常数 0.1  
    err_ratio=TrainPara(8);    %最大误差比率 1e10  
end  
% 输入层到中间层的传递函数  
if (length(InputFun)==0)  
    InputFun = 'tansig';  
end  
% 中间层到输出层的传递函数   
if (length(OutputFun)==0)  
    OutputFun = 'purelin';  
end     
tp=[df me eg lr lr_inc lr_idec mom_const err_ratio];  
%tp=[df me eg 0.001 0.001 10 0.1 1e10];  
frin_para=fopen(sprintf('input_para%s%s',ModelNo,'.txt'),'r');      %输入数据文件  
frout_para=fopen(sprintf('output_para%s%s',ModelNo,'.txt'),'r');    %输出数据文件  
[p,count]=fscanf(frin_para,'%f',[InputDim,data_num]);  %取输入数据  
[t,count]=fscanf(frout_para,'%f',[OutputDim,data_num]); %取输出数据  
fclose(frin_para);  
fclose(frout_para);  
 
[r,q]=size(p); [s2,q]=size(t);  
[w1,b1]=rands(MidDim,r);  
[w2,b2]=rands(s2,MidDim);  
NNTWARN OFF  
[w1,b1,w2,b2,epochs,errors]=trainlm(w1,b1,InputFun,w2,b2,OutputFun,p,t,tp);  
%将网络训练结果写入文件  
fww1=fopen(sprintf('w%s%s',ModelNo,'1.dat'),'w');  
fwb1=fopen(sprintf('b%s%s',ModelNo,'1.dat'),'w');  
fww2=fopen(sprintf('w%s%s',ModelNo,'2.dat'),'w');  
fwb2=fopen(sprintf('b%s%s',ModelNo,'2.dat'),'w');  
fprintf(fww1,'%9.4f ',w1);  
fprintf(fwb1,'%9.4f ',b1);  
fprintf(fww2,'%9.4f\n',w2);  
fprintf(fwb2,'%9.4f\n',b2);  
fclose(fww1);  
fclose(fwb1);  
fclose(fww2);  
fclose(fwb2);  
%将训练过程误差写入误差文件  
ferr=fopen(sprintf('lm_err%s%s',ModelNo,'.dat'),'w');  
fprintf(ferr,'%10.6f\n',errors);  
fclose(ferr);  
cd(olddir);  
retstr=epochs;  
%close all;  

