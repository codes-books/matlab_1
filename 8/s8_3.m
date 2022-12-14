>> load nelec;  								%装载信号
index=1:512;
x=nelec(index);
[c,l]=wavedec(x,5,'haar');  					% 用小波haar对信号进行5层分解
alpha=1.4;
[thr,nkeep]=wdcbm(c,l,alpha); 				% 获取信号压缩的阈值
[xd,cxd,lxd,perf0,perfl2]=wdencmp('lvd',c,l,'haar',5,thr,'s');  	
% 对信号进行压缩
subplot(2,1,1);  
plot(index,x);  
title('初始信号');  
subplot(2,1,2);  
plot(index,xd);  
title('经过压缩处理的信号');
