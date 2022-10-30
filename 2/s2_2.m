clear all
clc
P=[0.2 0.6;0.4 0.3;0.5 0.3;0.7 0.6];%输入量
T=[1 0];%目标值
[R,Q]=size(P);
[S,Q]=size(T);
W=zeros(S,R);
max_epoch=10;
lp.lr = 0.2;
%%%%%%%%%%训练内星%%%%%%%%%%
for epoch=1:(max_epoch)
    for q=1:Q
        A=T(q);
        dW=learnis(W,P(:,q),[],[],A,[],[],[],[],[],lp,[]);
        W=W+dW;
    end
end
