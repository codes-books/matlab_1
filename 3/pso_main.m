clear
clc
x_range=[-40,40];              %参数x变化范围
y_range=[-40,40];              %参数y变化范围
range = [x_range;y_range];     %参数变化范围
Max_V = 0.2*(range(:,2)-range(:,1));  %最大速度取变化范围的10%~20%
n=2;                     %待优化函数的维数
pso_Trelea_vectorized('pso_func',n,Max_V,range)  %调用PSO核心函数
