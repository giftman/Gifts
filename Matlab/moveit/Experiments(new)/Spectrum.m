%%%%%%%%%% project 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% AR(1) model, a1=0.9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% compute corelation function and power spectral density %%%%%
clear all
close all
clc;
X0=0;
N=1000;
rh=0.9;
X=zeros(1,N);
w=rand(1,N)-1/2;


X(1)=rh*X0+w(1);
 for i=2:N
     X(i)=rh*X(i-1)+w(i);
 end
 
 M=50;
 Rx=zeros(1, M+1);
 for m=1:M+1
     for n=1:N-m+1
         Rx(m)=Rx(m)+X(n)*X(n+m-1);
     end
     Rx(m)=Rx(m)/(N-m+1);
 end
 
 subplot(211),plot(Rx);
 xlabel('m')
 ylabel('Rx(m)')
 
 
 %%% compute power spectrum %%%
 
 ts=0.01;
 fs=1/ts;
 L=2^(nextpow2(M));
 Sx=fft(Rx,L);
 Sx=Sx/fs;
 df=fs/L;
 f=[0:df:df*(L-1)]-fs/2;
 
 subplot(212), plot(f,fftshift(abs(Sx)));
 xlabel('f')
 ylabel('Sx(f)')
 
 