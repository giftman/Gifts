clear;
clc;
bit_len=88;
N=44;
K=8;
p=128;
Q=16;
W=P/K;
b=randint(K,bit_len);
d=zeros(K,bit_len/2);
for user=1:K
    for jj=1:bit_len/2)
        if b(user,2*jj-1)==0&&b(user,2*jj)==0
            d(user,jj)=j;
        elseif b(user,2*jj-1_==0&&b(user,2*jj)==1
            d(user,jj)=1;
             elseif b(user,2*jj-1==1&&b(user,2*jj)==0
            d(user,jj)=-1;
             elseif b(user,2*jj-1==1&&b(user,2*jj)==1
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
scram=[-1 1 -1 -1 -1 1 -1 -1 1 -1 1 1 -1 1 -1 -1];
w=ones(1,N);
scran=kron(w,scram);
s=zeros(size(spread));
for user=1:K
    s(user,:)=spread(user,:).*scram;
end
%**********************************************************
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
R_DE=real(D_E）；
I_DE=imag(D_E);
Re=real(E);
Im=imag(E);
 Delay=3;
 R=0.22;
 Fd=1;
 Fs=4;
 [ys,ts]=rcosine(Fd,Fs,'fir/sqrt',R,Delay);
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
 r_It=real(channel_sum);
 r_Qt=imag(channel_sum);
 [yr1,tr1]=rcosflt(r_It,Fd,Fs,'filter/Fs',ys);
 [yr2,tr2]=rcosflt(r_Qt,Fd,Fs,'filter/Fs',ys);
 ryr1=yr1.';
 ryr2=yr2.';
 %*******************************************
 for jj=0:N*Q+144+16+W-2
     D_Isample(1,jj+1)=ryr1(1,25+jj*4);
     D_Qsample(1,jj+1)=ryr2(1,25+jj*4);
 end
 D_Rresult=R_DE_D_Isample(1:864);
 D_Iresult=I_DE_D_Qsanmple(1:864);
 data=D_Isample+j*D_Qsample;
 %*********************************************
 Lm=144;
 f_mid=N*Q/2+W;
  1_mid=N*Q/2+Lm-1;
  e=data(1,f_mid:1_mid);
  basic=[1,-1,1,1,-1,-1,1,-1,1,-1,1,-1,1,1,-1,-1,-1,1,-1,-1,-1,-1,1,-1,-1,-1,-1,-1,1,1,1,1,...
      -1,1,1,1,1,1,-1,-1,1,-1,-1,-1,1,1,-1,1,1,1,1,-1,1,-1,1,1,1,1,1,1,1,-1,1,-1,...
      -1,1,1,-1,1,-1,-1,1,-1,1,-1,1,-1,-1,-1,-1,-1,1,-1,1,1,-1,-1,1,1,-1,-1,-1,-1,-1,-1,1,...
      1,-1,1,1,1,1,-1,-1,1,1,-1,1-1,-1,-1,-1,-1,-1,1,-11,-1,-1,-11,1,-1,-1,-1,-1,1,1];
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
for user=1:K
    hhk(user,:)==hh_s((user-1)*W+1:user*W);
    subplot(2,4,user);
    ph=1:1:W;
    plot(ph,abs(hhk(user,:)));
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
    H_K=H_k_widen(:,1:N*Q);
    B_K=H_k_*C_k;
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
    dd_restor(user,:)=d_restore((user-1)*N+1:user*N);
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
        elseif test_sesult==test(2)
            bb(user,2*jj-1)=1;
            bb(user,2*jj)=0;
           elseif test_sesult==test(3)
            bb(user,2*jj-1)=1;
            bb(user,2*jj)=1;  
             elseif test_sesult==test(4)
            bb(user,2*jj-1)=0;
            bb(user,2*jj)=1;
        end;
    end;
end;
%*************************************************
error=bb-b;
for user=1:K
    count(user)=0;
    for jj=1:bit_len
        if error(user,jj)~=0        %(呜呜~~符号不知道怎么打出来）
            count(user)=county（user)+1;
        end;
    end;
end;
count
%****************************************************
function[mid_amble,GP]=midamble(K,P,user)
%*********************************************
W=P/K;
Lm=144;
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
mid_amble=zeros(1,Lm);
for ii=1:Lm
    mid_amble(1,ii)=m(1,ii+(K-user)*W);
end
GP=2*random('bino',1,0.5,1,16)-1;
for k=1:16
    if(mod(k,2)~=0)
        GP(k)=GP(k)*j;
    end
end
            

            
        
    
            
    

      

      
     

    
    