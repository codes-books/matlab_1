function f=ACOTSP
% C��ʾn�����е����꣬n��2�ľ���
% NC_max��ʾ����������
% m��ʾ���ϸ���
% Alpha��ʾ������Ϣ����Ҫ�̶ȵĲ���
% Beta��ʾ��������ʽ������Ҫ�̶ȵĲ���
% Rho��ʾ��Ϣ������ϵ��
% Q��ʾ��Ϣ������ǿ��ϵ��
% R_best��ʾ�������·��
% L_best��ʾ�������·�ߵĳ���
x=[51 27 56 21 4 6 58 71 54 53 94 18 89 33 12 25 24 58 71 94 17 38 13 82 12 58 45 11 47 4]';
y=[14 81 67 92 64 19 98 18 62 69 30 54 10 46 34 18 42 69 61 78 16 40 10 7 32 17 21 26 35 90]';
C=[x y];
NC_max=50;
m=30;
Alpha=1.4;
Beta=2.2;
Rho=0.15;
Q=10^6;
%%%%%%%%������ʼ��%%%%%%%%%%%%%%%%
n=size(C,1); %n��ʾ����Ĺ�ģ�����и�����
D=zeros(n,n);%D��ʾ��ȫͼ�ĸ�Ȩ�ڽӾ���
for i=1:n
    for j=1:n
        if i~=j
           D(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2)^0.5;
        else
           D(i,j)=eps;      
           %i=jʱ�����㣬Ӧ��Ϊ0�����������������Ҫȡ��������eps��������Ծ��ȣ���ʾ
        end
        D(j,i)=D(i,j);   %�Գƾ���
    end
end
Eta=1./D;                     %EtaΪ�������ӣ�������Ϊ����ĵ���
Tau=ones(n,n);                %TauΪ��Ϣ�ؾ���
Tabu=zeros(m,n);              %�洢����¼·��������
NC=1;                         %��������������¼��������
R_best=zeros(NC_max,n);       %�������·��
L_best=inf.*ones(NC_max,1);   %�������·�ߵĳ���
L_ave=zeros(NC_max,1);        %����·�ߵ�ƽ������
while NC<=NC_max              %ֹͣ����֮һ���ﵽ������������ֹͣ
%%%%%%%%��mֻ���Ϸŵ�n��������%%%%%%%%%%%%
Randpos=[];                   %�漴��ȡ
for i=1:(ceil(m/n))
    Randpos=[Randpos,randperm(n)];
end
Tabu(:,1)=(Randpos(1,1:m))';    
%%%%%%%%mֻ���ϰ����ʺ���ѡ����һ�����У���ɸ��Ե�����%%%%%%%%%%%%
for j=2:n                         %���ڳ��в�����
    for i=1:m     
        visited=Tabu(i,1:(j-1));  %��¼�ѷ��ʵĳ��У������ظ�����
        J=zeros(1,(n-j+1));       %�����ʵĳ���
        P=J;                      %�����ʳ��е�ѡ����ʷֲ�
        Jc=1;
    for k=1:n
        if length(find(visited==k))==0   %��ʼʱ��0
           J(Jc)=k;
           Jc=Jc+1;            	         %���ʵĳ��и����Լ�1
        end
    end
%��������ѡ���еĸ��ʷֲ�
    for k=1:length(J)
        P(k)=(Tau(visited(end),J(k))^Alpha)*(Eta(visited(end),J(k))^Beta);
    end
        P=P/(sum(P));
%������ԭ��ѡȡ��һ������
        Pcum=cumsum(P);          %cumsum��Ԫ���ۼӼ����
        Select=find(Pcum>=rand); %������ĸ��ʴ���ԭ���ľ�ѡ������·��
        to_visit=J(Select(1));
        Tabu(i,j)=to_visit;
    end
end
if NC>=2
   Tabu(1,:)=R_best(NC-1,:);
end
%%%%%%%%��¼���ε������·��%%%%%%%%%%%%
L=zeros(m,1);                        %��ʼ����Ϊ0��m*1��������
for i=1:m
    R=Tabu(i,:);
for j=1:(n-1)
    L(i)=L(i)+D(R(j),R(j+1));        %ԭ������ϵ�j�����е���j+1�����еľ���
end
L(i)=L(i)+D(R(1),R(n));              %һ���������߹��ľ���
end
L_best(NC)=min(L);                   %��Ѿ���ȡ��С
pos=find(L==L_best(NC));
R_best(NC,:)=Tabu(pos(1),:);         %���ֵ���������·��
L_ave(NC)=mean(L);                   %���ֵ������ƽ������
NC=NC+1;                             %��������
%%%%%%%%������Ϣ��%%%%%%%%%%%%%%%%
Delta_Tau=zeros(n,n);                %��ʼʱ��Ϣ��Ϊn*n��0����
for i=1:m
    for j=1:(n-1)
        Delta_Tau(Tabu(i,j),Tabu(i,j+1))=Delta_Tau(Tabu(i,j),Tabu(i,j+1))+Q/L(i);           
%�˴�ѭ����·����i��j���ϵ���Ϣ������
    end
Delta_Tau(Tabu(i,n),Tabu(i,1))=Delta_Tau(Tabu(i,n),Tabu(i,1))+Q/L(i);
%�˴�ѭ��������·���ϵ���Ϣ������
end
Tau=(1-Rho).*Tau+Delta_Tau;      %������Ϣ�ػӷ������º����Ϣ��
%%%%%%%%���ɱ�����%%%%%%%%%%%%
Tabu=zeros(m,n);                 %%ֱ������������
end
%%%%%%%%���%%%%%%%%%%%%
Pos=find(L_best==min(L_best));   %�ҵ����·������0Ϊ�棩
Shortest_Route=R_best(Pos(1),:)  %���������������·��
Shortest_Length=L_best(Pos(1))   %��������������̾���
figure
subplot(1,2,1);                  %���Ƶ�һ����ͼ��
DrawRoute(C,Shortest_Route);     %��·��ͼ���Ӻ���
subplot(1,2,2);                  %���Ƶڶ�����ͼ��
plot(L_best);
hold on                        
plot(L_ave,'r');
title('ƽ���������̾���')      
