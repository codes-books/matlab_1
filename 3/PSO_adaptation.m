function [xm,fv] = PSO_adaptation(fitness,N,c1,c2,wmax,wmin,M,D)
format long;
% fitness学习函数
% c1学习因子1
% c2学习因子2
% w惯性权重
% M最大迭代次数
% D搜索空间维数
% N初始化群体个体数目
% xm目标函数取最小值时的自变量
% fv目标函数最小值
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%初始化种群的个体%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for j=1:D
        x(i,j)=randn;  
        v(i,j)=randn; 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%先计算各个粒子的适应度%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);             %Pg表示全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%进入主要循环%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t=1:M
    for j=1:N
        fv(j) = fitness(x(j,:));
    end
    fvag = sum(fv)/N;
    fmin = min(fv);
    for i=1:N
        if fv(i) <= fvag
            w = wmin + (fv(i)-fmin)*(wmax-wmin)/(fvag-fmin);
        else
            w = wmax;
        end
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
end
xm = pg';          %目标函数取最小值时的自变量
fv = fitness(pg);  %目标函数最小值


