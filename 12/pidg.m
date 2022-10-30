function [KK,Bsj]=pidg(KK,Bsj)
global rin yout timef 
ts=0.001;
sys=tf(500,[1,50,1]);  % ���ض���Ϊ���״��ݺ���
dsys=c2d(sys,ts,'z');  %��Z�任
[num,den]=tfdata(dsys,'v');

rin=1.0;    % �����ź�Ϊ��Ծ�ź� 
u_1=0.0;u_2=0.0;  
y_1=0.0;y_2=0.0;
x=[0 0 0];
B=0;err_1=0;tu=1;s=0;P=100;

for k=1:P
    timef(k)=k*ts;
    r(k)=rin;
    
    u(k)=sum(KK.*x);  %���������
    
    if u(k)>=10       % Լ������
        u(k)=10;
    end
    if u(k)<=-10
        u(k)=-10;
    end
    %���������ź�
    yout(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
    err(k)=r(k)-yout(k);
    %���� PID����
    u_2=u_1;u_1=u(k);
    y_2=y_1;y_1=yout(k);
    
    x(1)=err(k);            %���� P
    x(2)=(err(k)-err_1)/ts; %���� D
    x(3)=x(3)+err(k)*ts;    %���� I
    err(2)=err_1;
    err_1=err(k);
    if s==0
        if yout(k)>0.95&yout(k)<1.05
            tu=timef(k);    % tuΪ����ʱ��
            s=1;            % ������̬����
        end
    end
end

for i=1:P
    % ����ۺ���ֵ
    Ji(i)=0.999*abs(err(i))+0.01*u(i)^2*0.1;
    B=B+Ji(i);
    if i>1
        erry(i)=yout(i)-yout(i-1);  % ϵͳ���
        if erry(i)<0                % ��������������ȡ�ͷ���ʩ
            B=B+100*abs(erry(i));
        end
    end
end
Bsj=B+0.2*tu*10;   % ���Ŵ���ֵ
