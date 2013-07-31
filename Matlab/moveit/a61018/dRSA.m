function [Mcode] = dRSA(NcodeRSA, d, n) 
LNRSA=length(NcodeRSA);
for NK=1:LNRSA
    prex2=NcodeRSA(1,NK);
    X2=prex2^d;
    M=mod(X2,n);
    Mcode(1,NK)=double(M);
end
Mcode = char(Mcode);