t=[0.1:0.1:2*pi];
s=(cos(t)+2).*sin(t);
[sqnr8,aquan8,code8]=upcm(s,8);

[sqnr16,aquan16,code16]=upcm(s,16);

plot(t,s,t,aquan8,'-.',t,aquan16,'*');
%legend('原始正弦信号'，'级数为8的PCM量化后信号','级数为16的PCM量化后信号')；