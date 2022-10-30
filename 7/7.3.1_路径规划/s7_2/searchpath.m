%寻找路径
%n:路径条数 m分开平面数 information:信息素 z高度表
%starty starth 出发点
%endy endh 终点
%path 寻到路径

function [path,information]=searchpath(n,m,information,z,starty,starth,endy,endh)
ycMax=2;   %横向最大变动
hcMax=2;   %纵向最大变动
decr=0.8;  %衰减概率

for ii=1:n
    path(ii,1:2)=[starty,starth];  
    oldpoint=[starty,starth];   %当前坐标点 
    %k:当前层数
    for k=2:m-1
        %计算所有数据点对应的适应度值
        kk=1;
        for i=-ycMax:ycMax
            for j=-hcMax:hcMax
                point(kk,:)=[oldpoint(1)+i,oldpoint(2)+j];
                if (point(kk,1)<20)&&(point(kk,1)>0)&&(point(kk,2)<17)&&(point(kk,2)>0)
                    %计算启发值
                    qfz(kk)=CacuQfz(point(kk,1),point(kk,2),oldpoint(1),oldpoint(2),endy,endh,k,z);
                    qz(kk)=qfz(kk)*information(k,point(kk,1),point(kk,2));
                    kk=kk+1;
                else
                    qz(kk)=0;
                    kk=kk+1;
                end
            end
        end   
        
        %选择下个点
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
        
        %更新信息素
        information(k+1,oldpoint(1),oldpoint(2))=0.5*information(k+1,oldpoint(1),oldpoint(2));
        
        %路径保存
        path(ii,k*2-1:k*2)=[oldpoint(1),oldpoint(2)];       
    end
    path(ii,41:42)=[endy,endh];
end
    
    