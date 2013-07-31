function [sqnr,a_quan,code]=upcm(a,n)
%U_PCM 采样样本序列a的均匀PCM编码.
% [SQNR,A_QUAN,CODE]=U_PCM(A,N)
% a=输入序列.
% n=量化级别数 (偶数).
% sqnr=输出的SQNR (以dB为单位).
% a_quan=编码之前的量化输出.
% code=编码后的输出.
amax=max(abs(a));
a_quan=a/amax;
b_quan=a_quan;
d=2/n;
q=d.*[0:n-1]-((n-1)/2)*d;

for i=1:n
    a_quan(find((q(i)-d/2 <= a_quan) & (a_quan <= q(i)+d/2)))=
    q(i).*ones(1,length(find((q(i)-d/2 <= a_quan) & (a_quan <= q(i)+d/2))));
    b_quan(find( a_quan==q(i) ))=(i-1).*ones(1,length(find( a_quan==q(i) )));
end

a_quan=a_quan*amax;
nu=ceil(log2(n));

code=zeros(length(a),nu);

for i=1:length(a)
    for j=nu:-1:0
        if ( fix(b_quan(i)/(2^j)) == 1)
                code(i,(nu-j)) = 1;
                b_quan(i) = b_quan(i) - 2^j;
        end
    end
end
sqnr=20*log10(norm(a)/norm(a-a_quan));