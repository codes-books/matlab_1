function [ net ] = gabptrain( gaP,bpP,P,T )
%gabptrain ����Ŵ��㷨��������ѵ��
%  gaP Ϊ�Ŵ��㷨�Ĳ�����Ϣ.[�Ŵ����� ��С��Ӧֵ]��
%  bpP Ϊ�����������Ϣ��[��������������С���]
%  P Ϊ��������
%  T ΪĿ������
[W1, B1, W2, B2] = getWBbyga(gaP);
net = initnet(W1, B1, W2, B2,bpP);
net = train(net,P,T);