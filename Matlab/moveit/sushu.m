function [t]=sushu(n)
k=floor(sqrt(n));
for i=2:k
    if mod(n,i)==0
        t=0;
        break;%��ʾ����i����ʱ��������������ֹѭ��
    else
        t=1;
    end
end 