function F=fitness(x)
F=0;
for i=1:30
    F=F+x(i)^2+x(i)-6
end
% x=zeros(1,30);
% [xm1,fv1]=PSO(@fitness,50,1.5,2.5,0.5,100,30);
% [xm2,fv2]=PSO(@fitness,50,1.5,2.5,0.5,1000,30);
% [xm3,fv3]=PSO(@fitness,50,1.5,2.5,0.5,10000,30);