% clear all
% clc
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %函数f(x)=11*sin(6*x)+7*cos(5*x)    x∈[-pi,pi]
% %%%%%绘制题中函数图形%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x=(-2*pi):0.5:(2*pi);
% [a,b]=size(x);
% for i=1:b
%     y(i)=11*sin(6*i)+7*cos(5*i);
% end
% plot(x,y,'r')
% title('函数曲线图')
% xlabel('x')
% ylabel('f(x)')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%主程序%%%%%%%%%%%%%%%%%%%% 
clear all
clc
popsize=30;                             %设置初始参数，群体大小  
chromlength=8;                          %字符串长度（个体长度），染色体长度  
pc=0.7;                                 %设置交叉概率 
pm=0.02;                                %设置变异概率   
pop=initpop(popsize,chromlength);       %运行初始化函数，随机产生初始群体 
for i=1:30                              %20为迭代次数  
     [objvalue]=calobjvalue(pop);       %计算目标函数  
     fitvalue=calfitvalue(objvalue);    %计算群体中每个个体的适应度 
     [newpop]=selection(pop,fitvalue);  %复制 
     [newpop]=crossover(pop,pc);        %交叉 
     [newpop]=mutation(pop,pc);         %变异  
     [bestindividual,bestfit]=best(pop,fitvalue);%求出群体中适应值最大的个体及其适应值 
     y(i)=max(bestfit); 
     n(i)=i;  
     pop5=bestindividual;  
     x(i)=decodechrom(pop5,1,chromlength)*10/1023; 
     pop=newpop; 
end
fplot('11*sin(6*x)+7*cos(5*x)',[-pi pi]) 
grid on
hold on 
plot(x,y,'r*') 
xlabel('自变量')
ylabel('目标函数值')
title('种群中的个体数目为30，二进制编码长度为8，交叉概率为0.7，变异概率为0.02')
fmax=max(y);
hold off

% %%%%%%%%%%%%%%%%初始化%%%%%%%%%%%%%%%%%%%%%%%%  
% function pop=initpop(popsize,chromlength)  
% pop=round(rand(popsize,chromlength)); 
% %popsize表示群体的大小，chromlength表示染色体的长度(二值数的长度)
% 
% %%%%%%%%%%%%%%%%计算目标函数值%%%%%%%%%%%%%%%%%%%%%%%%  
% %产生 [2^n 2^(n-1) ... 1] 的行向量，然后求和，将二进制转化为十进制 
% function pop2=decodebinary(pop) [px,py]=size(pop); %求pop行和列数
%    for i=1:py  
%        pop1(:,i)=2.^(py-i).*pop(:,i); 
%    end
%    pop2=sum(pop1,2);                  
%    %求pop1的每行之和
% end 
% 
% %将二进制编码转换成十进制
% function pop2=decodechrom(pop,spoint,length)  
%     pop1=pop(:,spoint:spoint+length-1);
%     %取出第“spoint”位开始到第“spoint+length-1”位的参数  
%     pop2=decodebinary(pop1);   
%     %利用上面函数“decodebinary(pop)”将用二进制表示的个体基因变为十进制数
% end
%  
% %实现目标函数的计算 
% function [objvalue]=calobjvalue(pop)  
%     temp1=decodechrom(pop,1,8);     %将pop每行转化成十进制数 
%     x=temp1*10/1023;                %将二值域中的数转化为变量域的数
%     objvalue=11*sin(6*x)+7*cos(5*x);%计算目标函数值
% end
%     
% %%%%%%%%%%%%计算个体的适应值%%%%%%%%%%%%%%%%%%%%
% %计算个体的适应值 
% function fitvalue=calfitvalue(objvalue) 
%     global Cmin; 
%     Cmin=0;  
%     [px,py]=size(objvalue); 
%     for i=1:px  
%         if objvalue(i)+Cmin>0
%             temp=Cmin+objvalue(i); 
%         else
%             temp=0.0; 
%         end
%         fitvalue(i)=temp; 
%     end
%     fitvalue=fitvalue';
% end
%      
% %%%%%%%%%%%%选择复制%%%%%%%%%%%%%%%%%%  
% function [newpop]=selection(pop,fitvalue) 
%     totalfit=sum(fitvalue);     %求适应值之和  
%     fitvalue=fitvalue/totalfit; %单个个体被选择的概率  
%     fitvalue=cumsum(fitvalue);  
%     [px,py]=size(pop);  
%     ms=sort(rand(px,1));        %用轮盘赌形式，从小到大排列随机数
%     fitin=1;  %fitvalue(fitin)代表第fitin个个体的单个个体被选择的概率 
%     newin=1;   
%     while newin<=px  
%         if(ms(newin))<fitvalue(fitin)        
%         %ms(newin)表示的是ms列向量中第"newin"位数值，小于fitvalue(fitin)
%         newpop(newin,:)=pop(fitin,:);      
%         %赋值 ,即将旧种群中 的第fitin个个体保留到下一代(newpop) 
%         newin=newin+1; 
%         else
%             fitin=fitin+1; 
%         end
%     end
% end
%     
% %%%%%%%%%%%%交叉%%%%%%%%%%%%%%%%%%  
% function [newpop]=crossover(pop,pc) 
%     [px,py]=size(pop); 
%     newpop=ones(size(pop));
%     for i=1:2:px-1  
%         if(rand<pc)     % 产生一随机数与交叉概率比较 
%             cpoint=round(rand*py);  
%             newpop(i,:)=[pop(i,1:cpoint) pop(i+1,cpoint+1:py)]; 
%             newpop(i+1,:)=[pop(i+1,1:cpoint) pop(i,cpoint+1:py)];
%         else
%             newpop(i,:)=pop(i,:); 
%             newpop(i+1,:)=pop(i+1,:); 
%         end
%     end
% end
%     
% %%%%%%%%%%%%变异%%%%%%%%%%%%%%%%%%%%%%%%   
% function [newpop]=mutation(pop,pm) 
%     [px,py]=size(pop); 
%     newpop=ones(size(pop)); 
%     for i=1:px  
%         if(rand<pm)         %产生一随机数与变异概率比较 
%             mpoint=round(rand*py); 
%             if mpoint<=0 mpoint=1; 
%             end
%             newpop(i,:)=pop(i,:); 
%             if any(newpop(i,mpoint))==0 
%                 newpop(i,mpoint)=1; 
%             else
%                 newpop(i,mpoint)=0; 
%             end
%         else
%             newpop(i,:)=pop(i,:); 
%         end
%     end
% end
% 
% %%%%%%%%%%%%求出群体中最大的适应值及其个体%%%%%%%%%%%% 
% function [bestindividual,bestfit]=best(pop,fitvalue) 
%     [px,py]=size(pop); 
%     bestindividual=pop(1,:); 
%     bestfit=fitvalue(1); 
%     for i=2:px 
%         if fitvalue(i)>bestfit 
%             bestindividual=pop(i,:); 
%             bestfit=fitvalue(i); 
%         end
%     end
% end
%     
% %%%%%%%%%%%%求出最佳个体的对应X值%%%%%%%%%%%% 
% function t=decodebinary2(pop) 
%     [px,py]=size(pop); 
%     for j=1:py;      
%         pop1(:,j)=2.^(py-1).*pop(:,j);      
%         py=py-1;   
%     end
%     temp2=sum(pop1,2); 
%     t=temp2*2*pi/1023;
% end 