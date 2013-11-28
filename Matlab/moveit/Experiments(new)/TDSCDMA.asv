%%%%%:  This is a TD-SCDMA communication system simulation program using MATLAB software
%%%%%:  Source text documents provided by Nan-Nan Zhu, Communication Engineering 072
%%%%%:  Zhongkai University of Agriculture and Engineering
%%%%%:  Revised version provided by Yuan-Gen Wang  -- wygen@mail2.sysu.edu.cn
%%%%%:  Sun Yat-sen University
%%%%%:  Date: 15-12-2009
%%%%%:  Version: 1,0 
%%%%%:  Copyright(c) 2009 by Y.-G. Wang
%%%%%:  Thanks to Nan-Nan Zhu for her TD-SCDMA source text, because this is a tedious work.
%%%%%:  Again thanks to her support for my teaching task!
%
%
% 
clear all;
close all;
clc;

bit_len=88;
N=44;
K=8;
P=128;
Q=16;
W=P/K;

b=randint(K,bit_len);
d=zeros(K,bit_len/2);

for user=1:K
    for jj=1:bit_len/2
        if b(user,2*jj-1)==0&&b(user,2*jj)==0
            d(user,jj)=j;
        elseif b(user,2*jj-1)==0&&b(user,2*jj)==1
            d(user,jj)=1;
             elseif b(user,2*jj-1)==1&&b(user,2*jj)==0
            d(user,jj)=-1;
             elseif b(user,2*jj-1)==1&&b(user,2*jj)==1
            d(user,jj)=-j;
        end
    end
end

%*************************************************************
ovsf=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
    1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1;
    1 1 1 1 -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1;
    1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1;
    1 1 -1 -1 1 1 -1 -1 1 1 -1 -1 1 1 -1 -1;
    1 1 -1 -1 1 1 -1 -1 -1 -1 1 1 -1 -1 1 1;
    1 1 -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1 1 1;
    1 1 -1 -1 -1 -1 1 1 -1 -1 1 1 1 1 -1 -1;
    1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1;
    1 -1 1 -1 1 -1 1 -1 -1 1 -1 1 -1 1 -1 1;
    1 -1 1 -1 -1 1 -1 1 1 -1 1 -1 -1 1 -1 1;
    1 -1 1 -1 -1 1 -1 1 -1 1 -1 1 1 -1 1 -1;
    1 -1 -1 1 1 -1 -1 1 1 -1 -1 1 1 -1 -1 1;
    1 -1 -1 1 1 -1 -1 1 -1 1 1 -1 -1 1 1 -1;
    1 -1 -1 1 -1 1 1 -1 1 -1 -1 1 -1 1 1 -1;
    1 -1 -1 1 -1 1 1 -1 -1 1 1 -1 1 -1 -1 1];
spread=zeros(K,N*Q);
for user=1:K
    spread(user,:)=kron(d(user,:),ovsf(user,:));
end
%***************************************************************
%%加扰
scram=[-1 1 -1 -1 -1 1 -1 -1 1 -1 1 1 -1 1 -1 -1];  %是不是随机的-1，1？如果是，为何不用随机生成？
w=ones(1,N);
scram=kron(w,scram);
s=zeros(size(spread));
for user=1:K
    s(user,:)=spread(user,:).*scram;%直接spread(user,:)=spread(user,:).*scram也可以吧？
end

%**********************************************************形成突发结构
for user=1:K
    [mid_amble,GP]=midamble(K,P,user);
    len1=length(s(user,:))/2;
    len2=len1;
    len3=length(mid_amble);
    len=len1+len2+len3+16;
    e=zeros(1,len);
    for ii=1:len1
        e(ii)=s(user,ii);
        e(ii+len1+len3)=s(user,ii+len1);
    end
    for ii=1:len3
        e(ii+len1)=mid_amble(ii);
    end
    for ii=1:16
        e(ii+len1+len3+len2)=GP(ii);
    end
    E(user,:)=e;
end
%*************************************************************
D_E=sum(E(:,:));
R_DE=real(D_E);
I_DE=imag(D_E);
Re=real(E);
Im=imag(E);


 Delay=3;
 R=0.22;
 Fd=1;
 Fs=4;
 [ys,ts]=rcosine(Fd,Fs,'fir/sqrt',R,Delay);%生成升余弦滤波器，都不是很明白。。。
 %通过升余弦滤波器，为什么是每个用户的实部虚部分别通过，不是整个E的实部虚部通过？
 
 %本函数为平方根升余弦成形 
%注意y =rcosflt(x,Fd,Fs,'filter_type',r,delay,tol)中采用的是2*delay码元成形，该函数延时ceil((delay-0.5)*num_sample个样点 
%函数y=rcosflt(x,Fd,Fs,'filter_type',r,delay,tol)的输出y和输入x长度满足length(y)=(length(x) + 2 * delay)*Fs/Fd，详见rcosflt_analysis.m 
%本函数去掉了延时，且使输出y和输入x一样长 
%输入x为非采样双极性序列，函数中进行采样,delay和r是成形时所需的参数，采用的是2*delay码元成形，r为滚降系数，Fd和Fs分别为码元速率和采样速率 
%function y=hxl_rcosflt(x,Fd,Fs,r,delay) 
%num_sample=Fs/Fd; 
%y_delay=(rcosflt(x,Fd,Fs,'fir/sqrt',r,delay))';   %成形并采样,注意rcosflt(x,Fd,Fs,'filter_type',r,delay,tol) 输出为列向量,求转置变成行向量后再赋值给y_delay 
%y=y_delay(ceil((delay-0.5)*num_sample)+1:ceil((delay-0.5)*num_sample)+length(x)*num_sample);%去掉延时，且使输出y和输入x一样长 
 
 
 
 
 
 for user=1:K
     [y1(user,:),t1]=rcosflt(Re(user,:),Fd,Fs,'filter',ys);
     [y2(user,:),t2]=rcosflt(Im(user,:),Fd,Fs,'filter',ys);
    send_data(user,:)=y1(user,:)+j*y2(user,:);
 end
 
 %******************************************************************
 Ts=0.02;
 Fmax=2;
 tau=[1,2,3,5];
 pdb=[3,4,6,9];
 chan=rayleighchan(Ts,Fmax,tau,pdb);
 channel_hh=[1,zeros(1,243)];
 channel_h=filter(chan,channel_hh);
 for jj=1:61
     sample_h(jj)=channel_h(jj*4);
 end
 for user=1:K
     channel_out(user,:)=conv(send_data(user,:),sample_h);
 end
 channel_sum=sum(channel_out(:,:));
 
 G_channel_sum=awgn(channel_sum,1,'measured');
 
 %接收端虚实分离
 r_It=real(channel_sum);
 r_Qt=imag(channel_sum);
 [yr1,tr1]=rcosflt(r_It,Fd,Fs,'filter/Fs',ys);
 [yr2,tr2]=rcosflt(r_Qt,Fd,Fs,'filter/Fs',ys);
 ryr1=yr1.';
 ryr2=yr2.';
 %*******************************************
 for jj=0:N*Q+144+16+W-2  %0到878
     D_Isample(1,jj+1)=ryr1(1,25+jj*4);  %从第25个开始每四个码片抽样1个，前24个为时延
     D_Qsample(1,jj+1)=ryr2(1,25+jj*4);
 end
 D_Rresult=R_DE-D_Isample(1:864);
 D_Iresult=I_DE-D_Qsample(1:864);
 data=D_Isample+j*D_Qsample;
 %*********************************************
 Lm=144;
 f_mid=N*Q/2+W;
  l_mid=N*Q/2+Lm-1;
  e=data(1,f_mid:l_mid);
  basic=[1,-1,1,1,-1,-1,1,-1,1,-1,1,-1,1,1,-1,-1,-1,1,-1,-1,-1,-1,1,-1,-1,-1,-1,-1,1,1,1,1,...
        -1,1,1,1,1,1,-1,-1,1,-1,-1,-1,1,1,-1,1,1,1,1,-1,1,-1,1,1,1,1,1,1,1,-1,1,-1,...
        -1,1,1,-1,1,-1,-1,1,-1,1,-1,1,-1,-1,-1,-1,-1,1,-1,1,1,-1,-1,1,1,-1,-1,-1,-1,-1,-1,1,...
         1,-1,1,1,1,1,-1,-1,1,1,-1,1,-1,-1,-1,-1,-1,-1,1,-1,1,-1,-1,-1,1,1,-1,-1,-1,-1,1,1];
      L=Lm+(K-1)*W;
      m=zeros(1,L);
 for ii=1:L
     if ii<=P
         m(1,ii)=(j^ii)*basic(1,ii);
     else
         m(1,ii)=m(1,ii-P);
     end
 end
 
G=zeros(P,P);

Position=0;
for ii=1:P
    for jj=1:P
        Position=mod(P+ii-jj-1,P)+1;
        G(ii,jj)=m(Position);
    end
end
inv_G=inv(G);
hh=inv_G*e.';
hh_s=hh.';
figure(1);
for user=1:K
    hhk(user,:)=hh_s((user-1)*W+1:user*W);
    subplot(2,4,user);
    ph=1:1:W;
    plot(ph,abs(hhk(user,:)));
    title(sprintf('     user %d system function', user));
end
%**************************************************************************
A=zeros(N*Q+W-1,K*N);
I_N=eye(N);
for user=1:K
    scram=[-1,1,-1,-1,-1,1,-1,-1,1,-1,1,1,-1,1,-1,-1];
    C_k=kron(I_N,(ovsf(user,:).*scram).');
    width=N*Q+W-1;
    H_k_widen=zeros(width,width);
    for ii=1:width
        indx_hh=1;
        col=ii;
        while(col>0)&&(indx_hh<=W);
            H_k_widen(ii,col)=hhk(user,indx_hh);
            col=col-1;
            indx_hh=indx_hh+1;
        end
    end
    H_k=H_k_widen(:,1:N*Q);
    B_k=H_k*C_k;
    A(:,(user-1)*N+1:user*N)=B_k;
end


x1=data(1:N*Q/2);
x2=data(N*Q/2+145:N*Q+144+15);
xx=[x1,x2];
a_A=A';
AA=inv(a_A*A);
d_estimate=AA*a_A;
dd_estimate=d_estimate*(xx.');
d_restore=dd_estimate.';
%**********************************************************************
for user=1:K
    dd_restore(user,:)=d_restore((user-1)*N+1:user*N);
end;
bb=zeros(K,88);
for user=1:K
    for jj=1:N
        for kk=1:4
            test(kk)=abs(dd_restore(user,jj)-j^kk);
        end;
        test_result=min(test);
        if test_result==test(1)
            bb(user,2*jj-1)=0;
            bb(user,2*jj)=0;
        elseif test_result==test(2)
            bb(user,2*jj-1)=1;
            bb(user,2*jj)=0;
        elseif test_result==test(3)
            bb(user,2*jj-1)=1;
            bb(user,2*jj)=1;
        elseif test_result==test(4)
            bb(user,2*jj-1)=0;
            bb(user,2*jj)=1;
        end;
    end;
end;
figure(2);
num_plot=1;
for user=1:K
    subplot(16,1,num_plot),stem(b(user,:));
    title(sprintf('user %d original signal', user));
    subplot(16,1,num_plot+1),stem(bb(user,:));
    title(sprintf('user %d reconstructed signal', user));
    num_plot=num_plot+2;
end
%*************************************************
error=bb-b;
for user=1:K
    count(user)=0;
    for jj=1:bit_len
        if error(user,jj)~=0  
            count(user)=count(user)+1;
        end;
    end;
end;
count
%****************************************************

            

            
        
    
            
    

      

      
     

    
    