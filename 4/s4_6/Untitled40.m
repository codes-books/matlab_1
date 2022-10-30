% x=-1:0.1:1;
x=linspace(-1,1);
% [a,b]=size(x);
% for i=1:b
%     y(i)=2+i.*sin(10*pi*i);
% end
y=10+x.*cos(5*pi*x);
figure(1); 
% plot(x,y,'r')
plot(x,y,'r')
title('ÊýÇúÏßÍ¼')
xlabel('x')
ylabel('f(x)')