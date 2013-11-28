function[codeRSA] = eRSA(mRSA,e,n);
%mRSA = K_des_RSA;
LRSA=length(mRSA);
for k=1:LRSA
    prex1=mRSA(1,k);
    X1=prex1^e;
    C=mod(X1,n);
    codeRSA(1,k)=double(C);
end