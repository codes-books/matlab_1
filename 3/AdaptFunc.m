%%%%%自适应权重法求解函数1%%%%%%%%%
function y=AdaptFunc(x)
y=((sin(x(1)^2+ x(2)^2))^2-cos(x(1)^2+ x(2)^2)+1)/((1+0.1*(x(1)^2+ x(2)^2))^2)-0.7;
end
