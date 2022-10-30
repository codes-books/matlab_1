%%%%%%%%%%设置参数%%%%%%%%%%
clear all
clc
T=[0.2 0.6;0.4 0.3;0.5 0.3;0.7 0.6];
P=[1 0];
[R,Q]=size(P);
[S,Q]=size(T);
W=zeros(S,R);
max_epoch=10;
lp.lr = 0.3;
%%%%%%%%%%根据外星学习规则进行训练%%%%%%%%%%
for epoch=1:(max_epoch)
    for q=1:Q
        A=T(:,q);
        dW=learnos(W,P(:,q),[],[],A,[],[],[],[],[],lp,[]);
        W=W+dW;
    end
end

Ptest=[1];
A=purelin(W*Ptest)

