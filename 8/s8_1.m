clear  all
clc
t=0:0.01:3;						%时间间隔为0.01说明采样频率为100 Hz
x=sin(2*pi*30*t)+sin(2*pi*500*t);	%产生主要频率为30Hz和500Hz的信号
f=x+3.4*randn(1,length(t));			%在信号中加入白噪声
subplot(121);
plot(f);							%画出原始信号的波形图
ylabel('幅值');
xlabel('时间');
title('原始信号');
y=fft(f,1024);	%对原始信号进行离散傅里叶变换，参加DFT的采样点个数为1024
p=y.*conj(y)/1024;					%计算功率谱密度
ff=100*(0:511)/1024;				%计算变换后不同点所对应的频率值
subplot(122);
plot(ff,p(1:512));					%画出信号的频谱图
ylabel('功率谱密度');
xlabel('频率');
title('信号功率谱图');
