clear all
clc
fisMat=newfis('s5_9');
fisMat=addvar(fisMat,'input','成绩',[0  10]);
fisMat=addvar(fisMat,'output','奖学金',[0  100]);
fisMat=addmf(fisMat,'input',1,'差','gaussmf',[1.2  0]);
fisMat=addmf(fisMat,'input',1,'中等','gaussmf',[1.2  5]);
fisMat=addmf(fisMat,'input',1,'很好','gaussmf',[1.2  10]);
fisMat=addmf(fisMat,'output',1,'低','trapmf',[0 0 10 50]);
fisMat=addmf(fisMat,'output',1,'中等','trimf',[10 30 80]);
fisMat=addmf(fisMat,'output',1,'高','trapmf',[50 80 100 100]);
rulelist=[1 1 1 1;2 2 1 1; 3 3 1 1];
fisMat=addrule(fisMat,rulelist);
subplot(3,1,1);plotmf(fisMat,'input',1);xlabel('成绩');ylabel('输入隶属度');
subplot(3,1,2);plotmf(fisMat,'output',1);xlabel('奖学金');ylabel('输出隶属度')
subplot(3,1,3);gensurf(fisMat);