clear
clc
x_range=[-40,40];              %����x�仯��Χ
y_range=[-40,40];              %����y�仯��Χ
range = [x_range;y_range];     %�����仯��Χ
Max_V = 0.2*(range(:,2)-range(:,1));  %����ٶ�ȡ�仯��Χ��10%~20%
n=2;                     %���Ż�������ά��
pso_Trelea_vectorized('pso_func',n,Max_V,range)  %����PSO���ĺ���
