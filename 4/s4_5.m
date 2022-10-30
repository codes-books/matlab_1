% clear all
% clc
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %����f(x)=11*sin(6*x)+7*cos(5*x)    x��[-pi,pi]
% %%%%%�������к���ͼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x=(-2*pi):0.5:(2*pi);
% [a,b]=size(x);
% for i=1:b
%     y(i)=11*sin(6*i)+7*cos(5*i);
% end
% plot(x,y,'r')
% title('��������ͼ')
% xlabel('x')
% ylabel('f(x)')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%������%%%%%%%%%%%%%%%%%%%% 
clear all
clc
popsize=30;                             %���ó�ʼ������Ⱥ���С  
chromlength=8;                          %�ַ������ȣ����峤�ȣ���Ⱦɫ�峤��  
pc=0.7;                                 %���ý������ 
pm=0.02;                                %���ñ������   
pop=initpop(popsize,chromlength);       %���г�ʼ�����������������ʼȺ�� 
for i=1:30                              %20Ϊ��������  
     [objvalue]=calobjvalue(pop);       %����Ŀ�꺯��  
     fitvalue=calfitvalue(objvalue);    %����Ⱥ����ÿ���������Ӧ�� 
     [newpop]=selection(pop,fitvalue);  %���� 
     [newpop]=crossover(pop,pc);        %���� 
     [newpop]=mutation(pop,pc);         %����  
     [bestindividual,bestfit]=best(pop,fitvalue);%���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ 
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
xlabel('�Ա���')
ylabel('Ŀ�꺯��ֵ')
title('��Ⱥ�еĸ�����ĿΪ30�������Ʊ��볤��Ϊ8���������Ϊ0.7���������Ϊ0.02')
fmax=max(y);
hold off

% %%%%%%%%%%%%%%%%��ʼ��%%%%%%%%%%%%%%%%%%%%%%%%  
% function pop=initpop(popsize,chromlength)  
% pop=round(rand(popsize,chromlength)); 
% %popsize��ʾȺ��Ĵ�С��chromlength��ʾȾɫ��ĳ���(��ֵ���ĳ���)
% 
% %%%%%%%%%%%%%%%%����Ŀ�꺯��ֵ%%%%%%%%%%%%%%%%%%%%%%%%  
% %���� [2^n 2^(n-1) ... 1] ����������Ȼ����ͣ���������ת��Ϊʮ���� 
% function pop2=decodebinary(pop) [px,py]=size(pop); %��pop�к�����
%    for i=1:py  
%        pop1(:,i)=2.^(py-i).*pop(:,i); 
%    end
%    pop2=sum(pop1,2);                  
%    %��pop1��ÿ��֮��
% end 
% 
% %�������Ʊ���ת����ʮ����
% function pop2=decodechrom(pop,spoint,length)  
%     pop1=pop(:,spoint:spoint+length-1);
%     %ȡ���ڡ�spoint��λ��ʼ���ڡ�spoint+length-1��λ�Ĳ���  
%     pop2=decodebinary(pop1);   
%     %�������溯����decodebinary(pop)�����ö����Ʊ�ʾ�ĸ�������Ϊʮ������
% end
%  
% %ʵ��Ŀ�꺯���ļ��� 
% function [objvalue]=calobjvalue(pop)  
%     temp1=decodechrom(pop,1,8);     %��popÿ��ת����ʮ������ 
%     x=temp1*10/1023;                %����ֵ���е���ת��Ϊ���������
%     objvalue=11*sin(6*x)+7*cos(5*x);%����Ŀ�꺯��ֵ
% end
%     
% %%%%%%%%%%%%����������Ӧֵ%%%%%%%%%%%%%%%%%%%%
% %����������Ӧֵ 
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
% %%%%%%%%%%%%ѡ����%%%%%%%%%%%%%%%%%%  
% function [newpop]=selection(pop,fitvalue) 
%     totalfit=sum(fitvalue);     %����Ӧֵ֮��  
%     fitvalue=fitvalue/totalfit; %�������屻ѡ��ĸ���  
%     fitvalue=cumsum(fitvalue);  
%     [px,py]=size(pop);  
%     ms=sort(rand(px,1));        %�����̶���ʽ����С�������������
%     fitin=1;  %fitvalue(fitin)�����fitin������ĵ������屻ѡ��ĸ��� 
%     newin=1;   
%     while newin<=px  
%         if(ms(newin))<fitvalue(fitin)        
%         %ms(newin)��ʾ����ms�������е�"newin"λ��ֵ��С��fitvalue(fitin)
%         newpop(newin,:)=pop(fitin,:);      
%         %��ֵ ,��������Ⱥ�� �ĵ�fitin�����屣������һ��(newpop) 
%         newin=newin+1; 
%         else
%             fitin=fitin+1; 
%         end
%     end
% end
%     
% %%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%  
% function [newpop]=crossover(pop,pc) 
%     [px,py]=size(pop); 
%     newpop=ones(size(pop));
%     for i=1:2:px-1  
%         if(rand<pc)     % ����һ������뽻����ʱȽ� 
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
% %%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%%%%%%%   
% function [newpop]=mutation(pop,pm) 
%     [px,py]=size(pop); 
%     newpop=ones(size(pop)); 
%     for i=1:px  
%         if(rand<pm)         %����һ������������ʱȽ� 
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
% %%%%%%%%%%%%���Ⱥ����������Ӧֵ�������%%%%%%%%%%%% 
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
% %%%%%%%%%%%%�����Ѹ���Ķ�ӦXֵ%%%%%%%%%%%% 
% function t=decodebinary2(pop) 
%     [px,py]=size(pop); 
%     for j=1:py;      
%         pop1(:,j)=2.^(py-1).*pop(:,j);      
%         py=py-1;   
%     end
%     temp2=sum(pop1,2); 
%     t=temp2*2*pi/1023;
% end 