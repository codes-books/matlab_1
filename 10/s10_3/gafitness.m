function f = gafitness(y)
% �Ŵ��㷨����Ӧֵ����
% y - Ⱦɫ�����
% f - Ⱦɫ����Ӧ��
[P,T,R,S1,S2,Q,S]=nninit;
x=y;

[W1, B1, W2, B2, P, T, A1, A2, SE, val]=gadecod(x);
f = val ;