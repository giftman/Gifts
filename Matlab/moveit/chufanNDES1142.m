% BY ͨ�Ź���071��  �Գ���   ��K1��Kno16 ��������

%d=[0 0 0 0 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1];
Nresult=[];
for ii=1:mn
    d=result((ii-1)*64+1:ii*64);%��64λΪһ��ȡ����
    m=[0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0];
    m=change(PC1,m);%m����������Կ��dΪ���յ����ݣ�ͨ��PC1תΪ56λ��
    d=change(IP,d);%����IPת��
    B=zeros(8,4);
    K=[];%K=K16
    C=[m(1:28)];
    D=[m(29:56)];
    for i=1:16         %����һλ������λ������PC2����K
       K=SK((17-i),:);%K�������
       L=d(1:32);%�����������
       R=d(33:64);%�����ұ�����
       d=change(E,R);%�ұ�������չΪ48λ
       d=bitxor(d,K);%����������K���
           for j=0:7   %��S�����
               M=d(1+6*j)*2+d(6+6*j)+1+4*j;
               N=d(2+6*j)*8+d(3+6*j)*4+d(4+6*j)*2+d(5+6*j)+1;
               z=[dec2bin(S(M,N))];
               z=double(z)-48;
               n=4-length(z);
               B((j+1),:)=[zeros(1,n),z];
           end
           d=B';%��������һ�����ڰ��������ת��һ��
           d=d(1:end);
           d=bitxor(d,L);%���ұ��������
           d=[R,d];%�ϲ�����λ��
    end
    d=[d(33:64),d(1:32)];%���һ�β��õ���λ�ã�������
    d=change(IP_1,d);%IP��ת��
    Nresult((ii-1)*64+1:ii*64)=d;
end


L=length(Nresult);%��ʼת����
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