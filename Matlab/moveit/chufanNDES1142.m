% BY 通信工程071班  赵楚凡   将K1到Kno16 保存起来

%d=[0 0 0 0 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1];
Nresult=[];
for ii=1:mn
    d=result((ii-1)*64+1:ii*64);%按64位为一份取数据
    m=[0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0];
    m=change(PC1,m);%m用于生成密钥，d为所收到数据，通过PC1转为56位。
    d=change(IP,d);%数据IP转换
    B=zeros(8,4);
    K=[];%K=K16
    C=[m(1:28)];
    D=[m(29:56)];
    for i=1:16         %左移一位或者两位，按照PC2生成K
       K=SK((17-i),:);%K生成完毕
       L=d(1:32);%保存左边数据
       R=d(33:64);%保存右边数据
       d=change(E,R);%右边数据扩展为48位
       d=bitxor(d,K);%生成数据与K异或
           for j=0:7   %经S盒输出
               M=d(1+6*j)*2+d(6+6*j)+1+4*j;
               N=d(2+6*j)*8+d(3+6*j)*4+d(4+6*j)*2+d(5+6*j)+1;
               z=[dec2bin(S(M,N))];
               z=double(z)-48;
               n=4-length(z);
               B((j+1),:)=[zeros(1,n),z];
           end
           d=B';%这行与下一行用于把数组矩阵转成一行
           d=d(1:end);
           d=bitxor(d,L);%与右边数列异或
           d=[R,d];%合并调换位置
    end
    d=[d(33:64),d(1:32)];%最后一次不用调换位置，换回来
    d=change(IP_1,d);%IP逆转换
    Nresult((ii-1)*64+1:ii*64)=d;
end


L=length(Nresult);%开始转回来
Zn=fix(L/7);
news=zeros(Zn,7);
for i=1:Zn
    temp=Nresult((i-1)*7+1:i*7);
    if (temp=='0000000')
       break
    else
       news(i,:)=temp;
    end
end
news=char(news+48);
news=bin2dec(news);
news=char(news);
news'
