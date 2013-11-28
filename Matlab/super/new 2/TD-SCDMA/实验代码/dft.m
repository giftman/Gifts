

function [Xk]=dft(xn,N)
%计算离散傅立叶变换
%Xk为在0<=n<N-1间的DFT系数数组
%xn为N点有限持续时间序列
%N为DFT的长度
n=0:N-1;   %n的行向量
k=0:N-1;  %k的行向量
WN=exp(-j*2*pi/N); %Wn因子
nk=n'*k;   %产生一个含nk值的N乘N维矩阵
WNnk=WN.^nk
Xk=xn*WNnk;%DFT系数行向量


