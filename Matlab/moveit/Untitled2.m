clear all
clc
p=43;q=59;
n=p*q;
n=dec2hex(n);
n = hex2dec(n);
n = dec2hex(n);
nn=(p-1)*(q-1);
e=13;
d=937;
format hex;
ss=11.^e;
ss=dec2hex(ss);
ssDec = hex2dec(ss);
ssHex = dec2hex(ssDec);
C=mod(ssHex,n)