%%%%%%%%%%%%%%%%�Ŵ��㷨�ڵ�·ͼ����ֵ�ָ��е�Ӧ��%%%%%%%%%%%%
function main()
clear all
close all
clc
global chrom oldpop fitness lchrom  popsize cross_rate mutation_rate thresholdsum
global maxgen  m n fit gen threshold A B C oldpop1 popsize1 b b1 fitness1 threshold1
A=imread('1.jpg');     %�����·ͼ��
A=imresize(A,0.5);     %����imresize����ͨ��Ĭ�ϵ�����ڲ�ֵ��ͼ��Ŵ�0.5��
B=rgb2gray(A);         %�ҶȻ�
C=imresize(B,0.2);     %�������ͼ����С��0.2��
lchrom=10;              %Ⱦɫ�峤��
popsize=10;            %��Ⱥ��С
cross_rate=0.8;        %�������
mutation_rate=0.5;     %�������
maxgen=100;            %������
[m,n]=size(C);
initpop;    %��ʼ��Ⱥ
for gen=1:maxgen
    generation;  %�Ŵ�����
end
findthreshold_best; %ͼ��ָ���
%%%%%%%%%%%%%%%%%%%�������������%%%%%%%%%%%
figure;
gen=1:maxgen;
plot(gen,fit(1,gen)); 
title('�����Ӧ��ֵ��������');
xlabel('����'),
ylabel('�����Ӧ��ֵ')
figure;
plot(gen,threshold(1,gen));
title('ÿһ���������ֵ�仯����');
xlabel('����'),
ylabel('ÿһ���������ֵ')
%%%%%%%%%%%%%%%%%%%��ʼ����Ⱥ%%%%%%%%%%%%%%%%%%%%
function initpop()
global lchrom oldpop popsize chrom C
imshow(C);
for i=1:popsize
    chrom=rand(1,lchrom);
    for j=1:lchrom
        if chrom(1,j)<0.5
            chrom(1,j)=0;
       else 
           chrom(1,j)=1;
        end
    end
    oldpop(i,1:lchrom)=chrom;    %��ÿһ���������8λ��Ⱦɫ�����
end

%%%%%%%%%%%%%%%%%������һ������%%%%%%%%%%%%%%%%%%%%%%
function generation()
fitness_order;                  %������Ӧ��ֵ������
select;                         %ѡ�����
crossover;                      %����
mutation;                       %����
%%%%%%%%%%%%%%%%%�����ʶ�ֵ��������%%%%%%%%%%%%%%%%%%%
function fitness_order()
global lchrom oldpop fitness popsize chrom fit gen C m n  fitness1 thresholdsum
global lowsum higsum u1 u2 threshold gen oldpop1 popsize1 b1 b threshold1 
if popsize>=5
    popsize=ceil(popsize-0.03*gen);
end
if gen==75     %��������ĩ�ڵ�ʱ�������Ⱥ��ģ�ͽ��桢�������
    cross_rate=0.3;        %�������
    mutation_rate=0.3;     %�������
end
%������ǵ�һ������һ�����������Ⱥ���ݴ˴�����Ⱥ��ģװ��˴���Ⱥ��
if gen>1   
    t=oldpop;
    j=popsize1;
    for i=1:popsize
        if j>=1
            oldpop(i,:)=t(j,:);
        end
        j=j-1;
    end
end
%�����ʶ�ֵ������
for i=1:popsize
    lowsum=0;
    higsum=0;
    lownum=0;
    hignum=0;
    chrom=oldpop(i,:);
    c=0;
    for j=1:lchrom
        c=c+chrom(1,j)*(2^(lchrom-j));
    end
    b(1,i)=c*255/(2^lchrom-1);  %ת�����Ҷ�ֵ        
    for x=1:m
        for y=1:n
            if C(x,y)<=b(1,i)
                lowsum=lowsum+double(C(x,y));%ͳ�Ƶ�����ֵ�ĻҶ�ֵ���ܺ�
                lownum=lownum+1; %ͳ�Ƶ�����ֵ�ĻҶ�ֵ�����ص��ܸ���
            else
                higsum=higsum+double(C(x,y));%ͳ�Ƹ�����ֵ�ĻҶ�ֵ���ܺ�
                hignum=hignum+1; %ͳ�Ƹ�����ֵ�ĻҶ�ֵ�����ص��ܸ���
            end
        end
    end
    if lownum~=0
        u1=lowsum/lownum; %u1��u2Ϊ��Ӧ�������ƽ���Ҷ�ֵ
    else
        u1=0;
    end
    if hignum~=0
        u2=higsum/hignum;
    else
        u2=0;
    end   
    fitness(1,i)=lownum*hignum*(u1-u2)^2; %�����ʶ�ֵ
end
if gen==1 %���Ϊ��һ������С��������
    for i=1:popsize
        j=i+1;
        while j<=popsize
            if fitness(1,i)>fitness(1,j)
                tempf=fitness(1,i);
                tempc=oldpop(i,:);
                tempb=b(1,i);
                b(1,i)=b(1,j);
                b(1,j)=tempb;
                fitness(1,i)=fitness(1,j);
                oldpop(i,:)=oldpop(j,:);
                fitness(1,j)=tempf;
                oldpop(j,:)=tempc;
            end
            j=j+1;
        end
    end
    for i=1:popsize
        fitness1(1,i)=fitness(1,i);
        b1(1,i)=b(1,i);
        oldpop1(i,:)=oldpop(i,:);
    end
    popsize1=popsize;
else %����һ��ʱ�������´�С��������
    for i=1:popsize
        j=i+1;
        while j<=popsize
            if fitness(1,i)>fitness(1,j)
                tempf=fitness(1,i);
                tempc=oldpop(i,:);
                tempb=b(1,i);
                b(1,i)=b(1,j);
                b(1,j)=tempb;
                fitness(1,i)=fitness(1,j);
                oldpop(i,:)=oldpop(j,:);
                fitness(1,j)=tempf;
                oldpop(j,:)=tempc;
            end
            j=j+1;
        end
    end
end 
%�±߶���һ��Ⱥ���������
for i=1:popsize1
    j=i+1;
    while j<=popsize1
        if fitness1(1,i)>fitness1(1,j)
            tempf=fitness1(1,i);
            tempc=oldpop1(i,:);
            tempb=b1(1,i);
            b1(1,i)=b1(1,j);
            b1(1,j)=tempb;
            fitness1(1,i)=fitness1(1,j);
            oldpop1(i,:)=oldpop1(j,:);
            fitness1(1,j)=tempf;
            oldpop1(j,:)=tempc;
        end
        j=j+1;
    end
end
%�±�ͳ��ÿһ���е������ֵ�������Ӧ��ֵ
if gen==1
    fit(1,gen)=fitness(1,popsize);
    threshold(1,gen)=b(1,popsize);
    thresholdsum=0;
else
    if fitness(1,popsize)>fitness1(1,popsize1)
        threshold(1,gen)=b(1,popsize); %ÿһ���е������ֵ
        fit(1,gen)=fitness(1,popsize);%ÿһ���е������Ӧ��
    else
        threshold(1,gen)=b1(1,popsize1); 
        fit(1,gen)=fitness1(1,popsize1);
    end
end

%%%%%%%%%%%%%%%%%%%��Ӣѡ��%%%%%%%%%%%%%%%%%%%%
function select()
global fitness popsize oldpop temp popsize1 oldpop1 gen b b1 fitness1
%ͳ��ǰһ��Ⱥ������Ӧֵ�ȵ�ǰȺ����Ӧֵ��ĸ���
s=popsize1+1;
for j=popsize1:-1:1
    if fitness(1,popsize)<fitness1(1,j)
        s=j;
    end
end
for i=1:popsize
    temp(i,:)=oldpop(i,:);
end
if s~=popsize1+1
    if gen<50  %С��50������һ��������Ӧ��ֵ���ڵ�ǰ���ĸ���������浱ǰ���еĸ���
        for i=s:popsize1
            p=rand;
            j=floor(p*popsize+1);
            temp(j,:)=oldpop1(i,:);
            b(1,j)=b1(1,i);
            fitness(1,j)=fitness1(1,i);
        end
    else
        if gen<100  %50~100������һ��������Ӧ��ֵ���ڵ�ǰ���ĸ�����浱ǰ���е�������
            j=1;
            for i=s:popsize1
                temp(j,:)=oldpop1(i,:);
                b(1,j)=b1(1,i);
                fitness(1,j)=fitness1(1,i);
                j=j+1;
            end
        else %����100������һ���е������һ����浱ǰ���е�����һ�룬�ӿ�Ѱ��
            j=popsize1;
            for i=1:floor(popsize/2)
                temp(i,:)=oldpop1(j,:);
                b(1,i)=b1(1,j);
                fitness(1,i)=fitness1(1,j);
                j=j-1;
            end
        end
    end
end
%����ǰ���ĸ������ݱ���
for i=1:popsize
    b1(1,i)=b(1,i); 
end    
for i=1:popsize
    fitness1(1,i)=fitness(1,i); 
end
for i=1:popsize
    oldpop1(i,:)=temp(i,:);
end
popsize1=popsize;
%%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%%%%%%%%%
function crossover()
global temp popsize cross_rate lchrom
j=1;
for i=1:popsize
    p=rand;
    if p<cross_rate
        parent(j,:)=temp(i,:);
        a(1,j)=i;
        j=j+1;
    end
end
j=j-1;
if rem(j,2)~=0
    j=j-1;
end
if j>=2
    for k=1:2:j
        cutpoint=round(rand*(lchrom-1));
        f=k;
        for i=1:cutpoint
            temp(a(1,f),i)=parent(f,i);
            temp(a(1,f+1),i)=parent(f+1,i);
        end
        for i=(cutpoint+1):lchrom
            temp(a(1,f),i)=parent(f+1,i);
            temp(a(1,f+1),i)=parent(f,i);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%%%%
function mutation()
global popsize lchrom mutation_rate temp newpop oldpop
sum=lchrom*popsize;    %�ܻ������
mutnum=round(mutation_rate*sum);    %��������Ļ�����Ŀ
for i=1:mutnum
    s=rem((round(rand*(sum-1))),lchrom)+1; %ȷ�����ڻ����λ��
    t=ceil((round(rand*(sum-1)))/lchrom); %ȷ����������ĸ�����
    if t<1
        t=1;
    end
    if t>popsize
        t=popsize;
    end
    if s>lchrom
        s=lchrom;
    end
    if temp(t,s)==1
        temp(t,s)=0;
    else
        temp(t,s)=1;
    end
end
for i=1:popsize
    oldpop(i,:)=temp(i,:);
end
%%%%%%%%%%%%%%%%%%%%%%�鿴���%%%%%%%%%%%%%%%%%%%%
function findthreshold_best()
global maxgen threshold m n C B A 
threshold_best=floor(threshold(1,maxgen)) %threshold_bestΪ�����ֵ
C=imresize(B,0.3);
figure
subplot(1,2,1)
imshow(A);
title('ԭʼ��·ͼ��')
subplot(1,2,2)
imshow(C);
title('ԭʼ��·�ĻҶ�ͼ')
figure;
subplot(1,2,1)
imshow(C);
title('ԭʼ��·�ĻҶ�ͼ')
[m,n]=size(C);
%�����ҵ�����ֵ�ָ�ͼ��
for i=1:m
    for j=1:n
        if C(i,j)<=threshold_best
            C(i,j)=0;
        else
            C(i,j)=255;
        end
    end
end
subplot(1,2,2)
imshow(C);
title('��ֵ�ָ��ĵ�·ͼ');