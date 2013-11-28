%%%%  project3 %%%%%%%%%%%%%%%%%%
%%%% mean PCM Quantization %%%%%%
%%%%% quantizate a sin signal for one peroid %%%%%%
t=[0:0.1:2*pi];
s=(cos(t)+2).*sin(t);
[snr_q8, aquan8, code8]=upcm(s,8);
[snr_q16, aquan16, code16]=upcm(s,16);
plot(t,s, t,aquan8,'-.', t,aquan16,'-');
legend('orignal sin signal', 'PCM signal of 8 level', 'PCM signal of 16 level');
snr_q8
snr_q16


 
