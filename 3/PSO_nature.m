function [xm,fv] = PSO_nature(fitness,N,c1,c2,w,M,D)
format long;
% N��ʼ��Ⱥ�������Ŀ
% c1ѧϰ����1
% c2ѧϰ����2
% w����Ȩ�� 
% M����������
% D�����ռ�ά��
%%%%%%%%%%%%��ʼ����Ⱥ�ĸ���%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for j=1:D
        x(i,j)=randn;  %��ʼ��λ��
        v(i,j)=randn;  %��ʼ���ٶ�
    end
end
%%%%%%%%%%%%�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg%%%%%%
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg = x(N,:);             %PgΪȫ������
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
%%%%%%%%%%%%��ѭ�������չ�ʽ���ε���%%%%%%%%%%%%
for t=1:M
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);       
        fx(i) = fitness(x(i,:));
        if fx(i)<p(i)
            p(i)=fx(i);
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end    
    [sortf,sortx] = sort(fx);    
    exIndex = round((N-1)/2);    
    x(sortx((N-exIndex+1):N)) = x(sortx(1:exIndex));   %�滻λ��
    v(sortx((N-exIndex+1):N)) = v(sortx(1:exIndex));   %�滻�ٶ�
end
xm = pg';
fv = fitness(pg);