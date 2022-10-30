clear all
clc
h=[1800 2200 1900 2400 2300 2100 2500 2400 2700 2600 2900
   1600 2000 2000 2600 2900 2000 2000 2500 2700 3000 2800
   2100 1900 2000 1900 1700 2000 2000 2000 2000 2500 2900
   1700 2000 2000 2000 1800 2000 2200 2000 2000 2000 2800
   2200 1800 2000 3100 2300 2400 1800 3100 3200 2300 2000
   1900 2100 2200 3000 2300 3000 3500 3100 2300 2600 2500
   1700 1400 2300 2900 2400 2800 1800 3500 2600 2000 3200
   2300 2500 2400 3100 3000 2600 3000 2300 3000 2500 2700
   2000 2200 2100 2000 2200 3000 2300 2500 2400 2000 2300
   2300 2200 2000 2300 2200 2200 2200 2500 2000 2800 2700
   2000 2300 2500 2200 2200 2000 2300 2600 2000 2500 2000];
h=h-1400;

for i=1:11
    for j=1:11
        h1(2*i-1,j)=h(i,j);
    end
end

for i=1:10
    for j=1:11
        h1(2*i,j)=(h1(2*i-1,j)+h1(2*i+1,j))/2;
    end
end

for i=1:21
    for j=1:11
        h2(i,2*j-1)=h1(i,j);
    end
end

for i=1:21
    for j=1:10
        h2(i,2*j)=(h2(i,2*j-1)+h2(i,2*j+1))/2;
    end
end

z=h2;      %初始地形

x=1:21;
y=1:21;
[x1,y1]=meshgrid(x,y);
figure(1)
mesh(x1,y1,z)
axis([1,21,1,21,0,2000])
xlabel('km')
ylabel('km')
zlabel('m')
for i=1:21
    information(i,:,:)=ones(21,21);     %初始信息素
end

%起点坐标
starty=10;
starth=3;

%终点坐标
endy=8;
endh=5; 

%n=10;
n=1;
m=21;

Best=[];
[path,information]=searchpath(n,m,information,z,starty,starth,endy,endh);  %路径寻找
fitness=CacuFit(path);                          %适应度计算
[bestfitness,bestindex]=min(fitness);           %最佳适应度
bestpath=path(bestindex,:);
Best=[Best;bestfitness];

%更新信息素
rou=0.5;
cfit=100/bestfitness;
k=2;
for i=2:m-1
    information(k,bestpath(i*2-1),bestpath(i*2))=(1-rou)*information(k,bestpath(i*2-1),bestpath(i*2))+rou*cfit;
end
    
    
for kk=1:1:100
    kk
    [path,information]=searchpath(n,m,information,z,starty,starth,endy,endh);  %路径寻找
    fitness=CacuFit(path);    %适应度计算
    [newbestfitness,newbestindex]=min(fitness);           %最佳适应度
    if newbestfitness<bestfitness
        bestfitness=newbestfitness;
        bestpath=path(newbestindex,:);
    end   
    Best=[Best;bestfitness];
    
    %更新信息素
    rou=0.2;
    cfit=100/bestfitness;
    k=2;
    for i=2:m-1
        information(k,bestpath(i*2-1),bestpath(i*2))=(1-rou)*information(k,bestpath(i*2-1),bestpath(i*2))+rou*cfit;
    end     
end

for i=1:21
    a(i,1)=bestpath(i*2-1);
    a(i,2)=bestpath(i*2);
end

% 绘制结果图形
figure(2)
plot(Best)
title('最佳个体适应度变化趋势')
xlabel('迭代次数')
ylabel('适应度值')

k=1:21
x=1:21;
y=1:21;
[x1,y1]=meshgrid(x,y);

figure(3)
mesh(x1,y1,z);
hold on
plot3(k',a(:,1)',a(:,2)'*200,'k-')
axis([1,21,1,21,0,2000])