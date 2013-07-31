clear all;
clc;
format compact;
N_user=8;
SNR=15;
c=[1 1 1 1 1 1 1 1;
    1 1 1 1 -1 -1 -1 -1;
    1 1 -1 -1 -1 -1 1 1 ;
    1 1 -1 -1 1 1 -1 -1;
    1 -1 -1 1 1 -1 -1 1 ;
    1 -1 -1 1 -1 1 1 -1 ;
    1 -1 1 -1 -1 1 -1 1 ;
    1 -1 1 -1 1 -1 1 -1 ];
Len_PN=length(c);
Len_Data=16;
Len_Chip=Len_PN*Len_Data;
Signal=randint(N_user,Len_Data);
for i=1:N_user
    SigSp(i,:)=kron(Signal(i,:),c(i,:));
end
TranSig(1:Len_Chip)=0;
for i=1:N_user
    TranSig(1,:)= TranSig(1,:)+SigSp(i,:);
end
RecSig=awgn(TranSig,SNR,'measured');
for j=1:N_uesr;
    for i=1:Len_Data
        De_Spr(j,Len_PN*(i-1)+1:Len_PN*i)=RecSig(Len_PN*(i-1)+1:Len_PN*i).*c(j,:);
    end
end
SigDeCorr(1:N_user,1:Len_Data)=0;
for j=1:N_user;
    for i=1:Len_Data
        if (SigDeCorr(j,i)>0.5)
            Rec_Data(j,i)=1;
        else
             Rec_Data(j,i)=0;
        end
    end
end
subplot(4,1,1)
stem(Signal(2,:));
title('第二个用户原始信号'）
subplot(4,1,2)
stairs(TranSig)
title('发射端8个用户叠加信号'）
subplot(4,1,3)
stem(SigDeCorr(2,:));
title('第二个用户接收端解相关后信号')
subplot(4,1,4)
stem(Rec_Data(2,:));
title('第二个用户接收端判决后的信号')
            
