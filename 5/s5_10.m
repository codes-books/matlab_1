clear all
clc
fisMat=newfis('ex5_10');
fisMat=addvar(fisMat,'input','��ѧ�ɼ�',[0  100]);
fisMat=addvar(fisMat,'input','���',[0  10]);
fisMat=addvar(fisMat,'output','ͨ����',[0  100]);
fisMat=addmf(fisMat,'input',1,'��','trapmf',[0 0 60 80]);
fisMat=addmf(fisMat,'input',1,'��','trapmf',[60 80 100 100]);
fisMat=addmf(fisMat,'input',2,'����','trimf',[0 1 5]);
fisMat=addmf(fisMat,'input',2,'��','trapmf',[1 5 10 10]);
fisMat=addmf(fisMat,'output',1,'��','trimf',[0 30 50]);
fisMat=addmf(fisMat,'output',1,'����','trimf',[30 50 80]);
fisMat=addmf(fisMat,'output',1,'��','trimf',[50 80 100]);
rulelist=[1 2 3 1 1; 2 2 1 1 1; 0 1 2 1 0];
fisMat=addrule(fisMat,rulelist);
gensurf(fisMat);
in=[50 1.5;80 2];
out=evalfis(in,fisMat)
