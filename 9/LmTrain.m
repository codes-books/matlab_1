% L-M�������㷨֮MATLABʵ��1 
%��ΪBP����ѵ������  
function retstr = LmTrain(ModelNo,NetPara,TrainPara,InputFun,OutputFun,DataDir)  
NNTWARN OFF  
retstr=-1;  
%%%% ���������ֵ��ʼ %%%%%%%%%%%%%%%%%%%%%%%  
% ������Գ����ã��������ʱȥ���ⲿ�ֵ�ע��  
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
%%%% ���������ֵ���� %%%%%%%%%%%%%%%%%%%%%%%%  
%����ԭĿ¼  
olddir=pwd;  
%������������Ŀ¼  
cd(DataDir);  
deltalin(1);  
deltalog(1);  
deltatan(1);  
% �������  
InputDim=NetPara(1);      %�����ڵ���  
OutputDim=NetPara(2);      %�����ڵ���  
MidDim=NetPara(3);        %�м��ڵ���  
data_num=NetPara(4);      %ѵ����������  
% ����ѵ������  
if (TrainPara == -1)  
    df = 25;              %��ʾ������� 25  
    me = 1000;            %���ѭ������ 1000  
    eg = 0.001;            %Ŀ����� 0.02  
    lr = 0.001;            %ѧϰ���� 0.001  
    lr_inc = 0.001;        %ѧϰ�������ӱ��� 0.001  
    lr_idec = 10;          %ѧϰ���ʼ��ٱ��� 10  
    mom_const = 0.1;      %�������� 0.1  
    err_ratio = 1e10;      %��������� 1e10  
else  
    df=TrainPara(1);            %��ʾ������� 25  
    me=TrainPara(2);            %���ѭ������ 1000  
    eg=TrainPara(3);            %Ŀ����� 0.02  
    lr=TrainPara(4);            %ѧϰ���� 0.001  
    lr_inc=TrainPara(5);        %ѧϰ�������ӱ��� 0.001  
    lr_idec=TrainPara(6);      %ѧϰ���ʼ��ٱ��� 10  
    mom_const=TrainPara(7);    %�������� 0.1  
    err_ratio=TrainPara(8);    %��������� 1e10  
end  
% ����㵽�м��Ĵ��ݺ���  
if (length(InputFun)==0)  
    InputFun = 'tansig';  
end  
% �м�㵽�����Ĵ��ݺ���   
if (length(OutputFun)==0)  
    OutputFun = 'purelin';  
end     
tp=[df me eg lr lr_inc lr_idec mom_const err_ratio];  
%tp=[df me eg 0.001 0.001 10 0.1 1e10];  
frin_para=fopen(sprintf('input_para%s%s',ModelNo,'.txt'),'r');      %���������ļ�  
frout_para=fopen(sprintf('output_para%s%s',ModelNo,'.txt'),'r');    %��������ļ�  
[p,count]=fscanf(frin_para,'%f',[InputDim,data_num]);  %ȡ��������  
[t,count]=fscanf(frout_para,'%f',[OutputDim,data_num]); %ȡ�������  
fclose(frin_para);  
fclose(frout_para);  
 
[r,q]=size(p); [s2,q]=size(t);  
[w1,b1]=rands(MidDim,r);  
[w2,b2]=rands(s2,MidDim);  
NNTWARN OFF  
[w1,b1,w2,b2,epochs,errors]=trainlm(w1,b1,InputFun,w2,b2,OutputFun,p,t,tp);  
%������ѵ�����д���ļ�  
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
%��ѵ���������д������ļ�  
ferr=fopen(sprintf('lm_err%s%s',ModelNo,'.dat'),'w');  
fprintf(ferr,'%10.6f\n',errors);  
fclose(ferr);  
cd(olddir);  
retstr=epochs;  
%close all;  

