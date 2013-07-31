%%%%%%%% project2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% exploit monte carlo method to estimate BER %%%%%%%%%%%%%%%%%%%%%
%N=input('Enter number of symblos>');% the nunber of random experience
N=50;
snrdB_min=-3;
snrdB_max=8;
snrdB=snrdB_min:1:snrdB_max;
snr=10.^(snrdB/10);
len_snr=length(snrdB);

for j=1:len_snr
    sigma=sqrt(1/(2*snr(j)));
    Ne=0;
    
    for k=1:N
        d=round(rand(1));% 0 or 1 value
        x_d=2*d-1;% -1 or 1 value
        n_d=sigma*randn(1);% AGWN
        y_d=x_d+n_d;
        
        if y_d>0
            d_est=1;
        else
            d_est=0;
        end
        if(d_est~=d)
                Ne=Ne+1;
        end
    end
     errors(j)=Ne;
     ber_sim(j)=errors(j)/N;
end

ber_theor=qfunc(sqrt(2*snr));
semilogy(snrdB, ber_theor, snrdB, ber_sim, '*')
%plot(snrdB, ber_theor, snrdB, ber_sim, '*')
axis([snrdB_min snrdB_max 0.0001 1])
xlabel('SNR in dB')
ylabel('BER')
legend('Theoretical', 'Estimated')
