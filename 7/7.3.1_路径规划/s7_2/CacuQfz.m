%����ÿ���������ֵ
function qfz=CacuQfz(nowy,nowh,oldy,oldh,endy,endh,k,z)
%nowy,nowh:���ڵ�
%endy,endh:�յ� 
%oldy,oldh:�ϸ���
%k:��ǰ����
%z:���θ߶�ͼ
if z(nowy,k)<nowh*200
    S=1;
else
    S=0;
end

%D����
D=50/(sqrt(1+(oldh*0.2-nowh*0.2)^2+(nowy-oldy)^2)+sqrt((21-k)^2+(endh*0.2-nowh*0.2)^2+(nowy-oldy)^2));

%����ı�
M=30/(abs(nowh-oldh)+1);
qfz=S*M*D; 