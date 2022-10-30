clear all
clc
%%初始化%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ant=300;  %蚂蚁数量
Times=80;  %蚂蚁移动次数
Rou=0.9;  %信息素挥发系数
P0=0.2;  %转移概率常数
Lower_1=-1;  %设置搜索范围
Upper_1=1;
Lower_2=-1;
Upper_2=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:Ant
    X(i,1)=(Lower_1+(Upper_1-Lower_1)*rand);  %随机设置蚂蚁的初值位置
    X(i,2)=(Lower_2+(Upper_2-Lower_2)*rand);
    Tau(i)=F(X(i,1),X(i,2));
end
 
step=0.05;
f='-(x.^4+3*y.^4-0.2*cos(3*pi*x)-0.4*cos(4*pi*y)+0.6)';
 
 
[x,y]=meshgrid(Lower_1:step:Upper_1,Lower_2:step:Upper_2);
z=eval(f);
figure(1);
subplot(1,2,1);
mesh(x,y,z);
hold on;
plot3(X(:,1),X(:,2),Tau,'k*')
hold on;
text(0.1,0.8,-0.1,'蚂蚁的初始分布位置');
xlabel('x');ylabel('y');zlabel('f(x,y)');
 
for T=1:Times
    lamda=1/T;
    [Tau_Best(T),BestIndex]=max(Tau);
    for i=1:Ant
        P(T,i)=(Tau(BestIndex)-Tau(i))/Tau(BestIndex);  %计算状态转移概率
    end
    for i=1:Ant
        if P(T,i)<P0  %局部搜索
            temp1=X(i,1)+(2*rand-1)*lamda;
            temp2=X(i,2)+(2*rand-1)*lamda;
        else  %全局搜索
            temp1=X(i,1)+(Upper_1-Lower_1)*(rand-0.5);
            temp2=X(i,2)+(Upper_2-Lower_2)*(rand-0.5);
        end
        
        %越界处理
        if temp1<Lower_1
            temp1=Lower_1;
        end
        if temp1>Upper_1
            temp1=Upper_1;
        end
        if temp2<Lower_2
            temp2=Lower_2;
        end
        if temp2>Upper_2
            temp2=Upper_2;
        end
        
        %%%
        if F(temp1,temp2)>F(X(i,1),X(i,2))  %判断蚂蚁是否移动
            X(i,1)=temp1;
            X(i,2)=temp2;
        end
    end
    for i=1:Ant
        Tau(i)=(1-Rou)*Tau(i)+F(X(i,1),X(i,2));  %更新信息量
    end
end
 
subplot(1,2,2);
mesh(x,y,z);
hold on;
x=X(:,1);
y=X(:,2);
plot3(x,y,eval(f),'k*');
hold on;
text(0.1,0.8,-0.1,'蚂蚁的最终分布位置');
xlabel('x');ylabel('y');zlabel('f(x,y)');
 
[max_value,max_index]=max(Tau);
maxX=X(max_index,1);
maxY=X(max_index,2);
maxValue=F(X(max_index,1),X(max_index,2));