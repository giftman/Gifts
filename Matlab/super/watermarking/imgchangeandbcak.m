clear all;close all;clc
zhongkai=[1 2 3;4 5 6;7 8 9];
zhongkai2=zeros(3,3);
num1=zhongkai(:);
for i=1:3
    for k=1:3
        zhongkai2(i,k)=num1(((i-1)*3+k),1);
    end
end
zhongkai2'

        
        
    