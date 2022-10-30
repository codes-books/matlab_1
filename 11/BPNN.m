%通用BP神经网络网络
clear all
clc
P=[-1 -1 2 2;0 5 0 5];
t=[-1 -1 1 1];
net=newff(minmax(P),[3,1],{'tansig','purelin'},'traingd');
%输入参数依次为:'样本P范围',[各层神经元数目],{各层传递函数},'训练函数'
%训练函数traingd--梯度下降法，有7个训练参数.
%训练函数traingdm--有动量的梯度下降法,附加1个训练参数mc(动量因子，缺省为0.9)
%训练函数traingda--有自适应lr的梯度下降法,附加3个训练参数:lr_inc(学习率增长比，缺省为1.05;
%                 lr_dec(学习率下降比，缺省为0.7);max_perf_inc(表现函数增加最大比，缺省为1.04)
%训练函数traingdx--有动量的梯度下降法中赋以自适应lr的方法，附加traingdm和traingda的4个附加参数
%训练函数trainrp--弹性梯度下降法,可以消除输入数值很大或很小时的误差，附加4个训练参数:
%             delt_inc(权值变化增加量，缺省为1.2);delt_dec(权值变化减小量，缺省为0.5);
%             delta0(初始权值变化，缺省为0.07);deltamax(权值变化最大值,缺省为50.0)
%             适合大型网络
%训练函数traincgf--Fletcher-Reeves共轭梯度法;训练函数traincgp--Polak-Ribiere共轭梯度法;
%训练函数traincgb--Powell-Beale共轭梯度法
%共轭梯度法占用存储空间小,附加1训练参数searchFcn(一维线性搜索方法,缺省为srchcha);缺少1个训练参数lr
%训练函数trainscg--量化共轭梯度法,与其他共轭梯度法相比，节约时间.适合大型网络                
%             附加2个训练参数:sigma(因为二次求导对权值调整的影响参数，缺省为5.0e-5);
%                            lambda(Hessian阵不确定性调节参数，缺省为5.0e-7)
%             缺少1个训练参数:lr
%训练函数trainbfg--BFGS拟牛顿回退法,收敛速度快,但需要更多内存,与共轭梯度法训练参数相同,适合小网络
%训练函数trainoss--一步正割的BP训练法,解决了BFGS消耗内存的问题,与共轭梯度法训练参数相同
%训练函数trainlm--Levenberg-Marquardt训练法,用于内存充足的中小型网络
net=init(net);
net.trainparam.epochs=300;   %最大训练次数(前缺省为10,自trainrp后，缺省为100)
net.trainparam.lr=0.05;     %学习率(缺省为0.01)
net.trainparam.show=50;     %限时训练迭代过程(NaN表示不显示，缺省为25)
net.trainparam.goal=1e-5; %训练要求精度(缺省为0)
%net.trainparam.max_fail     最大失败次数(缺省为5)
%net.trainparam.min_grad     最小梯度要求(前缺省为1e-10，自trainrp后，缺省为1e-6)
%net.trainparam.time       最大训练时间(缺省为inf)
[net,tr]=train(net,P,t);     %网络训练
a=sim(net,P)                 %网络仿真