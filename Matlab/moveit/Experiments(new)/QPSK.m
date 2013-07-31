clc;
close all;
clear all;
SNRindB1=0:1:12;
SNRindB2=0:0.2:12;
for i=1:length(SNRindB1);
    simu_err_prb(i)=simuPe_Qpsk(SNRindB1(i));
end;
for i=1:length(SNRindB2);
    SNR=10^(SNRindB2(i)/10);
    theo_err_prb(i)=2*qfunc(sqrt(4*SNR)/2);
end;
semilogy(SNRindB2,theo_err_prb,SNRindB1,simu_err_prb,'o');
axis([0 12 0.0001 1])
xlabel('SNR in dB')
ylabel('Prb of Err')
legend('Theoretical','Simulation')


            
            
            
            
