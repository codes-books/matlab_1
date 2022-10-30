% �����Ŵ��㷨��PID����
clear all
clc;
global rin yout timef  %����ȫ�ֱ���

G=50;      %��������
Size=30;    %��Ⱥ��С
CodeL=10;   %��Ⱥ���峤�ȣ������Ʊ��룩

MinX=zeros(1,3);      %Լ����������kp,kd,ki ��ȡֵ��Χ
MaxX(1)=20*ones(1);   % kp in [0 20]
MaxX(2)=1.0*ones(1);  % kd,ki in [0 1]
MaxX(3)=1.0*ones(1);

E=round(rand(Size,3*CodeL));  %��ʼ����Ⱥ������

Bsj=0;

for k=1:G          %��������
    time(k)=k;
    
    for s=1:Size
        m=E(s,:);
        y1=0;y2=0;y3=0;  %�������ʼ����ʮ���ƣ�
        
        m1=m(1:CodeL);
        for i=1:CodeL
            y1=y1+m1(i)*2^(i-1); %���������
        end
        K(s,1)=(MaxX(1)-MinX(1))*y1/1024+MinX(1); %���룬����Kp��ȡֵ
                
        m2=m(CodeL+1:2*CodeL);
        for i=1:CodeL
            y2=y2+m2(i)*2^(i-1); %���������
        end
        K(s,2)=(MaxX(2)-MinX(2))*y2/1024+MinX(2); %���룬����Kd��ȡֵ
               
        m3=m(2*CodeL+1:3*CodeL);
        for i=1:CodeL
            y3=y3+m1(i)*2^(i-1); %���������
        end
        K(s,3)=(MaxX(3)-MinX(3))*y1/1024+MinX(3); %���룬����Ki��ȡֵ
    
    %��Ӧ�Ⱥ���
    KK=K(s,:);
    [KK,Bsj]=pidg(KK,Bsj); % ����pidg.m
    Bsji(s)=Bsj;   % ���Ŵ���ֵ
    end
    
    [O,D]=sort(Bsji);  %���Ŵ���ֵ����
    Bestj(k)=O(1)    %ȡ��Сֵ
    BJ=Bestj(k);
    
  
    Ji=Bsji+1e-10;
    fi=1./Ji;          %��Ӧ����ֵ
    [O2,D2]=sort(fi);  %��Ӧ����ֵ����
    Bestfi=O2(Size);   %ȡ���ֵ
    Bests=E(D2(Size),:);

    %ѡ������
    fi_sum=sum(fi);
    fi_size=(O2/fi_sum)*Size;
    fi_s=floor(fi_size);  %ȡ�ϴ����Ӧֵ,ȷ����λ��
    kk=1;
    for i=1:Size
        for j=1:fi_s(i)  %ѡ�񣬸���
            tempE(kk,:)=E(D2(j),:); 
            kk=kk+1;
        end
    end
    
    %��������
    pc=0.6;   %�������
    n=30*pc;
    for i=1:2:(Size-1)
        temp=rand;
        if pc>temp   %��������
            for j=n:-1:1
                tempE(i,j)=E(i+1,j); %�¡�����Ⱥ���彻�滥��
                tempE(i+1,j)=E(i,j);
            end
        end
    end
    tempE(Size,:)=Bests;
    E=tempE;
    
    %��������
    pm=0.001-[1:1:Size]*(0.001)/Size; %�������ӣ��Ӵ�С
    for i=1:Size
        for j=1:2*CodeL
            temp=rand;
            if pm>temp  %��������
                if tempE(i,j)==0
                    tempE(i,j)=1;
                else
                    tempE(i,j)=0;
                end
            end
        end
    end
    tempE(Size,:)=Bests;
    E=tempE;
end

BJ,
Bestfi,
KK;
figure(1),plot(time,Bestj);
xlabel('Times');
ylabel('Best J');
figure(2),plot(timef,rin,'r',timef,yout,'b');
xlabel('Times');
ylabel('rin,yout');
