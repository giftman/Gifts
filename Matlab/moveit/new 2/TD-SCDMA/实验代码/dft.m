

function [Xk]=dft(xn,N)
%������ɢ����Ҷ�任
%XkΪ��0<=n<N-1���DFTϵ������
%xnΪN�����޳���ʱ������
%NΪDFT�ĳ���
n=0:N-1;   %n��������
k=0:N-1;  %k��������
WN=exp(-j*2*pi/N); %Wn����
nk=n'*k;   %����һ����nkֵ��N��Nά����
WNnk=WN.^nk
Xk=xn*WNnk;%DFTϵ��������


