clc;
clear;
f1=5; % Ƶ��1
f2=10; % Ƶ��2
fs=2*(f1+f2); % ����Ƶ��
Ts=1/fs; % �������
N=12; % ��������
n=1:N;
y=sin(2*pi*f1*n*Ts)+sin(2*pi*f2*n*Ts); % ���Ҳ����
figure(1)
plot(y);
title('���������ź�')
figure(2)
stem(abs(fft(y)));
title('���ź�Ƶ��')
h=wfilters('db6','l'); % ��ͨ
g=wfilters('db6','h'); % ��ͨ
h=[h,zeros(1,N-length(h))]; % ���㣨Բ�ܾ����������ֱ��ʱ��ڹ۲죩
g=[g,zeros(1,N-length(g))]; % ���㣨Բ�ܾ����������ֱ��ʱ��ڹ۲죩
figure(3);
stem(abs(fft(h)));
title('��ͨ�˲���ͼ')
figure(4);
stem(abs(fft(g)));
title('��ͨ�˲���ͼ')
sig1=ifft(fft(y).*fft(h)); % ��ͨ(��Ƶ����)
sig2=ifft(fft(y).*fft(g)); % ��ͨ(��Ƶ����)
figure(5); % �ź�ͼ
subplot(2,1,1)
plot(real(sig1));
title('�ֽ��ź�1')
subplot(2,1,2)
plot(real(sig2));
title('�ֽ��ź�2')
figure(6); % Ƶ��ͼ
subplot(2,1,1)
stem(abs(fft(sig1)));
title('�ֽ��ź�1Ƶ��')
subplot(2,1,2)
stem(abs(fft(sig2)));
title('�ֽ��ź�2Ƶ��')
sig1=dyaddown(sig1); % 2��ȡ
sig2=dyaddown(sig2); % 2��ȡ
sig1=dyadup(sig1); % 2��ֵ
sig2=dyadup(sig2); % 2��ֵ
sig1=sig1(1,[1:N]); % ȥ�����һ����
sig2=sig2(1,[1:N]); % ȥ�����һ����
hr=h(end:-1:1); % �ع���ͨ
gr=g(end:-1:1); % �ع���ͨ
hr=circshift(hr',1)'; % λ�õ���Բ������һλ
gr=circshift(gr',1)'; % λ�õ���Բ������һλ
sig1=ifft(fft(hr).*fft(sig1)); % ��Ƶ
sig2=ifft(fft(gr).*fft(sig2)); % ��Ƶ
sig=sig1+sig2; % Դ�ź�
figure(7);
subplot(2,1,1)
plot(real(sig1));
title('�ع���Ƶ�ź�');
subplot(2,1,2)
plot(real(sig2));
title('�ع���Ƶ�ź�');
figure(8);
subplot(2,1,1)
stem(abs(fft(sig1)));
title('�ع���Ƶ�ź�Ƶ��');
subplot(2,1,2)
stem(abs(fft(sig2)));
title('�ع���Ƶ�ź�Ƶ��');
figure(9)
plot(real(sig),'r','linewidth',2);
hold on;
plot(y);
legend('�ع��ź�','ԭʼ�ź�')
title('�ع��ź���ԭʼ�źűȽ�')
