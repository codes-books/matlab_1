%±äÒìº¯Êı Mutation.m

function a=Mutation(A)

index1=0;index2=0;

nnper=randperm(size(A,2));

index1=nnper(1);

index2=nnper(2);

%fprintf('index1=%d ',index1);

%fprintf('index2=%d ',index2);

 

temp=0;

temp=A(index1);

A(index1)=A(index2);

A(index2)=temp;

a=A;

end