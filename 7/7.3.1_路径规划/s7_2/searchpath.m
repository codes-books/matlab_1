%Ѱ��·��
%n:·������ m�ֿ�ƽ���� information:��Ϣ�� z�߶ȱ�
%starty starth ������
%endy endh �յ�
%path Ѱ��·��

function [path,information]=searchpath(n,m,information,z,starty,starth,endy,endh)
ycMax=2;   %�������䶯
hcMax=2;   %�������䶯
decr=0.8;  %˥������

for ii=1:n
    path(ii,1:2)=[starty,starth];  
    oldpoint=[starty,starth];   %��ǰ����� 
    %k:��ǰ����
    for k=2:m-1
        %�����������ݵ��Ӧ����Ӧ��ֵ
        kk=1;
        for i=-ycMax:ycMax
            for j=-hcMax:hcMax
                point(kk,:)=[oldpoint(1)+i,oldpoint(2)+j];
                if (point(kk,1)<20)&&(point(kk,1)>0)&&(point(kk,2)<17)&&(point(kk,2)>0)
                    %��������ֵ
                    qfz(kk)=CacuQfz(point(kk,1),point(kk,2),oldpoint(1),oldpoint(2),endy,endh,k,z);
                    qz(kk)=qfz(kk)*information(k,point(kk,1),point(kk,2));
                    kk=kk+1;
                else
                    qz(kk)=0;
                    kk=kk+1;
                end
            end
        end   
        
        %ѡ���¸���
        sumq=qz./sum(qz);
    
        pick=rand;
        while pick==0
            pick=rand;
        end
        
        for i=1:49
            pick=pick-sumq(i);
            if pick<=0
                index=i;
                break;
            end
        end
        
        oldpoint=point(index,:);
        
        %������Ϣ��
        information(k+1,oldpoint(1),oldpoint(2))=0.5*information(k+1,oldpoint(1),oldpoint(2));
        
        %·������
        path(ii,k*2-1:k*2)=[oldpoint(1),oldpoint(2)];       
    end
    path(ii,41:42)=[endy,endh];
end
    
    