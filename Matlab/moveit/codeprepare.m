data='iloveyouC#221';
da=dec2bin(double(data));
da=double(da)-48
da=da(:);
da=da';
l=length(da);
if(mod(l,48~=0))
    i=48-mod(l,48)
    da=[da,zeros(1,i)]
else
    
