t=[0.1:0.1:2*pi];
s=(cos(t)+2).*sin(t);
[sqnr8,aquan8,code8]=upcm(s,8);

[sqnr16,aquan16,code16]=upcm(s,16);

plot(t,s,t,aquan8,'-.',t,aquan16,'*');
%legend('ԭʼ�����ź�'��'����Ϊ8��PCM�������ź�','����Ϊ16��PCM�������ź�')��