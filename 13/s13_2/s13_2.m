clear all
clc
a1=clock;
%��ͼ���г�ȡһά������Ϊһά�ź�
Im=double(imread('1.bmp'));
t=0:400-1;
bat=Im(255,1:512);

iterative_number=50;%����
[a,N]=size(bat);
signal=bat;
signal_reconstruct=zeros(1,N);
signal_r=bat;
a_base=2;
j_min=0;
j_max=log2(N);
u_base=1/2;
p_min=0;

v_base=pi;%Ƶ��
k_min=0;

w_base=pi/6;
i_min=0;
i_max=12;

signal_reconstruct=(1/N)*sum(signal);
signal_r=signal-signal_reconstruct;
subplot(221);
plot(bat);
subplot(222);
plot(signal_reconstruct);
subplot(223);
plot(signal_r);
subplot(224);
plot(signal_reconstruct);
drawnow;

for n=1:iterative_number
[proj,scale,translation,freq,phase]=gas(signal_r,N,a_base,j_min,j_max,u_base,p_min,v_base,k_min,w_base,i_min,i_max);
%��ȡ�ؽ��������ԭ��
t=0:N-1;
t=(t-translation)/scale;
g=(1/sqrt(scale))*exp(-pi*t.*t).*cos(freq*t+phase);           
g=g/sqrt(sum(g.*g));
signal_reconstruct=signal_reconstruct+proj*g;
signal_r=signal_r-proj*g;
%��ʾ���
subplot(221);
plot(bat);
title('ԭʼ�ź�')
subplot(222);
plot(g);
title('ѡ�е�����ԭ��')
subplot(223);
plot(signal_r);
title('�źŷֽ��Ĳв�')
subplot(224);
plot(signal_reconstruct);
title('�ؽ����ź�')
drawnow;
n
end
time=etime(clock,a1)%���г���ʱ��