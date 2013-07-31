function [p,q]=simuPe_Qpsk(snr_in_dB)
E=1;
SNR=10^(snr_in_dB/10);
sgma=sqrt(E/(2*SNR));
s11=-j;
s10=-1;
s00=j;
s01=1;

N=10000;
signal=rand(1,2*N);
qpsk=zeros(1,N);
code=zeros(1,2,N);
for i=1:N
    if signal(2*i-1)<0.5
        if signal(2*i)<0.5
            qpsk(i)=s00;
            code(:,:,i)=[0 0];
        else qpsk(i)=s01;
            code(:,:,i)=[0 1];
        end
    else
        if signal(2*i)<0.5
            qpsk(i)=s10;
            code(:,:,i)=[1 0];
        else qpsk(i)=s11;
            code(:,:,i)=[1 1];
        end
    end
end
numoferr=0;
wubite=0;
for i=1:N
      n=sgma*(randn(1)+j*randn(1));
      r=qpsk(i)+n; 
      d11=real(r*conj(s11));
      d10=real(r*conj(s10));
      d00=real(r*conj(s00)); 
      d01=real(r*conj(s01));
      d_max=max([d11 d10 d00 d01]);
      
      if(d_max==d11)
          decis_qpsk=s11;
          jieshou=[1 1];
      elseif (d_max==d10);
          decis_qpsk=s10;
           jieshou=[1 0];
      elseif(d_max==d00);
          decis_qpsk=s00;
           jieshou=[0 0];
      else
          decis_qpsk=s01;
           jieshou=[0 1];
      end
      
      if (decis_qpsk~=qpsk(i))
          numoferr=numoferr+1;
          wubite=length(find((jieshou-code(:,:,i))~=0))+wubite;          
      end
end
p=numoferr/N;
q=wubite/(2*N);

            