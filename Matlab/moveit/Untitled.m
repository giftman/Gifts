L=length(Nresult)
Zn=fix(L/7);
news=zeros(Zn,7)
news=char(news+48)
for i=1:Zn
    temp=NN((i-1)*7+1:i*7);
    if (temp=='0000000')
       break
    else
       news(i,:)=temp;
    end
end
news=bin2dec(news)
char(news)