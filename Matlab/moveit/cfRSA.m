clear all%用一个数字标明长度，然后再将其显示为2进制数
clc
codeRSA=[];
p=43;q=59;
n=p*q;
nn=(p-1)*(q-1);
e=sym('13');
d=sym('937');
% for i=1:nn
%     if mod((i*nn+1),e)==0
%         d=(i*nn+1)/e;
%     break
%     end
% end
mRSA=[65 75 96 100 101];
LRSA=length(mRSA);
for k=1:LRSA
    prex1=mRSA(1,k);
    X1=prex1^e;
    C=mod(X1,n);
    codeRSA(1,k)=double(C);
end
codeRSA=dec2bin(codeRSA);
codeRSA=double(codeRSA)-48;
codeRSA=codeRSA';
codeRSA=codeRSA(:);
codeRSA=codeRSA';
codeRSA
