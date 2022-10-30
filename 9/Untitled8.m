clear
clc
tic,
%[x,y]=data;
x=[1 1 1;
1 2 3];
y=[2 3 4]; %%%%%--数据显示，输入为－两输入，输出为－单输出。--------样本为p2组
[p1,p2]=size(x);
%－ 一。首先要对样本进行聚类分析，以此来确定模糊规则个数。利用K-means法对样本聚类。

%????此处的K－ means 法待加

%－ 二。建立模糊推理系统

% 隶属度函数个数-－模糊规则个数
k=5;
% 初始化四个隶属度函数的参数A,B及输出层初始权值W

for i=1:p1;
    for j=1:k;
        m(i,j)=1+0.6*rands(1);
        b(i,j)=1+0.6*rands(1);
    end
end
for j=1:k;
    w(j)=100+rand(1);
end
%%%---推理计算输出值
for q=1:p2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-----用同一隶属度参数对 输入样本 X 累计计算
% 选用高斯函数作为隶属度，求隶属度，共 size(x,2)+k 个。x(1) K个，x(2) K个
    for i=1:p1;
        for j=1:k;
            u(i,j)=gaussmf(x(i,q),[m(i,j),b(i,j)]);
        end
    end
% 模糊推理计算：a21,a22.几个隶属度函数，得出几个值，本例中两个.
%%%%----由以前的取小做法改为相乘—prod(x,1) or prod(x,2)———
    for i=1:k;
        v(i)=1;
        j=1;
        while j<=p1;
            v(i)=v(i)*u(j,i);
            j=j+1;
        end
    end
% 归一化计算模糊推理的值；相当于已经除去了经典去模糊输出的分母值
%for i=1:k;
%a3(i)=a2(i)/sum(a2);
%end
% 系统输出
    out1(q)=w*v';
    e(q)=(y(q)-out1(q));
end
out=out1

%－ 三。参数修正过程。 增加方式，非批处理方式迭代
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%－－－－－－－－---------------------误差反向传播过程－－－-----------------------------------------
% 取误差函数：E＝(1/2)*sumsqr(t-y)
E=(1/2)*sumsqr(y-out)
EE=E;
e
% e=sum(y-out)
lr=0.3; % c2=zeros(2,2);
%%%%----------------------------------------误差反传后的参数修正过程-------------------
r=1;
p=1;
s=1000;
while p<=s & EE>1e-10
%%%%%%%%%%%%%_____隶属度参数 M. B 输出层权值参数 W 的修正过程_____%%%%%%%%%%%%
%%1.--W
wc=zeros(1,k);
for i=1:k;
wc(i)=lr*e(r)*v(i);
end
%%2.--M
mc=zeros(p1,k);
for i=1:p1;
for j=1:k;
mc(i,j)=2*lr*e(r) * w(j) * (v(j)/u(i,j)) * exp(-((x(i,r)-m(i,j)).^2)/(b(i,j).^2))* (x(i,r)-m(i,j))/(b(i,j).^2);
end
end
%%3.--B
bc=zeros(p1,k);
for i=1:p1;
for j=1:k;
bc(i,j)=2*lr*e(r)* w(j) * (v(j)/u(i,j)) * exp(-((x(i,r)-m(i,j)).^2)/(b(i,j).^2)) * ((x(i,r)-m(i,j)).^2)/(b(i,j).^3);
end
end
% 4.参数修正 m b w
m=m+mc;
b=b+bc;
w=w+wc;
%%%%%%%%%%%_______利用修正后的参数重新计算_____________%%%%%%%%%%%%%%%%%%%%%
% 5.利用修正过的参数重新计算输出
for q=1:p2; 
for i=1:p1;
for j=1:k;
u(i,j)=gaussmf(x(i,q),[m(i,j),b(i,j)]);
end
end
for i=1:k;
v(i)=1;
j=1;
while j<=p1;
v(i)=v(i)*u(j,i);
j=j+1;
end
end
out1(q)=w*v';
end
out=out1;
p=p+1;
EE=(1/2)*sumsqr(y-out);
E(p)=EE;
r=r+1;
if r>p2
r=1;
end
e(r)=(y(r)-out(r));
end
%%%%%%%%%%%%%%%%%%%________________当误差或迭代步数满足要求后得到结果_________________%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m,b,w,E_out=EE,e
epoch=1:size(E,2);
figure
plot(epoch,E,'-r');
axis([0 1.5*s min(E) max(E)]);
set(gca,'fontsize',8);
set(gca,'xtick',0:s/10:1.5*s);
%set(gca,'ytick',1e-30:1e5:1e5);
%set(gcf,'color','b')
title('误差变化曲线');xlabel('步数');ylabel('误差');
toc