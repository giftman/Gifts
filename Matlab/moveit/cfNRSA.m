codeRSA;
 p=43;q=59;
 n=p*q;
 Mcode=[];
% nn=(p-1)*(q-1);
% e=sym('13');
d=sym('937');
LN=length(codeRSA);%开始转回来
Zn=fix(LN/12);
NcodeRSA=zeros(Zn,12);
for i=1:Zn
    temp=codeRSA((i-1)*12+1:i*12);
    if (temp=='000000000000')
       break
    else
       NcodeRSA(i,:)=temp;
    end
end
NcodeRSA=char(NcodeRSA+48);
NcodeRSA=bin2dec(NcodeRSA);
% NcodeRSA=char(NcodeRSA);
NcodeRSA=NcodeRSA';
LNRSA=length(NcodeRSA);
for NK=1:LNRSA
    prex2=NcodeRSA(1,NK);
    X2=prex2^d;
    M=mod(X2,n);
    Mcode(1,NK)=double(M);
end
Mcode