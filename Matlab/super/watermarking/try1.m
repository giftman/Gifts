clear all;close all;clc
zhongkai=im2bw(imread('zhongkai.bmp'));
zhongkai2=logical(zeros(30,30));
num1=zhongkai(:);
for i=1:30
    for k=1:30
        zhongkai2(i,k)=num1(((i-1)*30+k),1);
    end
end
zhongkai2=zhongkai2';
imshow(zhongkai2)
        
    