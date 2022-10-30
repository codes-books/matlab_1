%计算每个点的启发值
function qfz=CacuQfz(nowy,nowh,oldy,oldh,endy,endh,k,z)
%nowy,nowh:现在点
%endy,endh:终点 
%oldy,oldh:上个点
%k:当前层数
%z:地形高度图
if z(nowy,k)<nowh*200
    S=1;
else
    S=0;
end

%D距离
D=50/(sqrt(1+(oldh*0.2-nowh*0.2)^2+(nowy-oldy)^2)+sqrt((21-k)^2+(endh*0.2-nowh*0.2)^2+(nowy-oldy)^2));

%纵向改变
M=30/(abs(nowh-oldh)+1);
qfz=S*M*D; 