function [t]=sushu(n)
k=floor(sqrt(n));
for i=2:k
    if mod(n,i)==0
        t=0;
        break;%表示当被i整出时，不是素数，终止循环
    else
        t=1;
    end
end 