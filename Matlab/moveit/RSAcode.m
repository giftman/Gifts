clear all
clc
mdata='Can you  ';
mRSA=double(mdata)
%�����Ϊm
mdata=dec2bin(mRSA)
mdata=double(mdata)-48;
mdata=mdata';
mdata=mdata(:);
mdata=mdata';
mdatal=length(mdata);
mdatai=64-mod(mdatal,64);
mdata=[mdata,zeros(1,mdatai)]
%RSA����ʾ�����ǿ�