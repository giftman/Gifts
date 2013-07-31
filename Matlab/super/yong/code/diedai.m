clear;
clc;
tic;
Image=imread('lena.bmp');
%imshow(Image);
Imagesize=size(Image);
a=[1 1;1 2];
K1=4;
u=2;
K2='2hjkh#$$^t%h&fjyjou';
sum_k=sum(K2);
r_k=K2(1);
r_k=dec2bin(r_k,8);
r_k=uint8(r_k)-48;
for i_k=2:length(K2)
         temp=K2(i_k);
         temp=dec2bin(temp,8);
         temp=uint8(temp)-48;
   r_k=bitxor(r_k,temp);
end
r_k=num2str(r_k);
r_k=bin2dec(r_k);
a1=mod((sum_k/256),1);
u1=3+mod(round(1000*a1),30);
b1=r_k/256;
b_ta=3+mod(round(1000*b1),30);
%%%%%%%%%%%%%%%arnold seting%%%%%%%%%%
xc1=a1*b1;
yc1=(a1+b1)/2;
x=a1;
toc;