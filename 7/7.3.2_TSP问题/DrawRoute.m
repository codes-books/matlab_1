function DrawRoute(C,R)
%��·��ͼ���Ӻ���
N=length(R);
scatter(C(:,1),C(:,2));
hold on
plot([C(R(1),1),C(R(N),1)],[C(R(1),2),C(R(N),2)],'b');
hold on
for ii=2:N
    plot([C(R(ii-1),1),C(R(ii),1)],[C(R(ii-1),2),C(R(ii),2)],'k');
    hold on
end
title('TSP�����Ż���� ')