clear all;
clc
% hgd = fopen('test.txt');
% hgd = fread(hgd);
hgd=('C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221C#221');
hgd = dec2bin(hgd);
hgd = double(hgd) - 48;
hgd = hgd';
hgd = hgd(:)';
len_hgd = length(hgd);
c_x = ceil(len_hgd / 64);
hgd = [hgd, zeros(1, c_x*64 - len_hgd)];
mi_des = zeros(c_x, 64);
disp('������16�ֽ���Կ(18����ĸ,�����ֱ���Ҫ26��)����ԿҪ�Ե����ű�ע');
K_des = input('');
K_des_RSA = double(K_des);
K_des = dec2bin(K_des_RSA);
K_des = double(K_des) - 48;
K_des = K_des';
K_des = K_des(:)';
K_des = [K_des, 1, 0];
K_des = K_des';
K_des = K_des(:);
K_des = K_des';
for i_3des = 1:c_x
    min = hgd((i_3des - 1)*64 + 1 : i_3des*64);
    mi_des(i_3des,:) = des(min, K_des);
end
%mi_des = char(mi_des + 48);%%%%%%%%�мǲ�����תΪchar����Ȼ�ӽ�����ʱ����ȷ
mi_des = mi_des';
mi_des = mi_des(:);
len_mi = length(mi_des);
count_mi_7 = ceil(len_mi / 7);
mi_des = [mi_des', zeros(1, (7 - mod(len_mi, 7)))];
for i_btoc = 1:count_mi_7
    mi_char(i_btoc,:) = mi_des((i_btoc - 1)*7+1 : i_btoc*7);
end
mi_char = char(mi_char + 48);
mi_char = char(bin2dec(mi_char));
disp('����Ϊ��')
mi_char = mi_char'
save mi_char mi_char 

% dlmwrite('miwen.txt',mi_char,'delimiter',' ','newline','pc')







disp('RSA����3DES��Կ')
codeRSA=[];
% % p=43;q=59;
% % n=p*q;
% % nn=(p-1)*(q-1);
% % e=sym('13');
% % d=sym('937');
% for i=1:nn
%     if mod((i*nn+1),e)==0
%         d=(i*nn+1)/e;
%     break
%     end
% end
disp('��ʼ��RSA....');
disp('��Դ�ϵͳ�����趨��ȷ������p,q,e');
p=input('���������p = ');
q=input('���������q = ');
disp('��Կn = ')
n=p*q
A=(p-1)*(q-1);
e=input('����һ��ŷ���������ʵ�����e��Ϊ��Կ��e = ');
g=gcd(A,e);
if g~=1;
    disp('�������e��A������');
    break;
end
e=sym(e);
for d=1:A
    if mod(d*e,A)==1
        disp('d = '),disp(d);
        break;
    end
end
disp('������Կd = ')
d;
d=sym(d);

%mRSA=[138 65 195 522];
codeRSA = eRSA(K_des_RSA, e, n);%%%%%%%%%%%%%RSA����
% mRSA = K_des_RSA;
% LRSA=length(mRSA);
% for k=1:LRSA
%     prex1=mRSA(1,k);
%     X1=prex1^e;
%     C=mod(X1,n);
%     codeRSA(1,k)=double(C);
% end
% % codeRSA=dec2bin(codeRSA);
% % codeRSA=double(codeRSA)-48;
% % cRSA_sym = size(codeRSA);
% % cRSA_SYM = cRSA_sym(2);
% % codeRSA=codeRSA';
% % codeRSA=codeRSA(:);
% % codeRSA=codeRSA';
disp('DES��Կ��RSA���ܽ����')
codeRSA
save codeRSA codeRSA 

disp('���ܿ�ʼ')
Mcode=[];
% nn=(p-1)*(q-1);
% e=sym('13');
% % d=sym('937');
% % LN=length(codeRSA);%��ʼת����
% % Zn=fix(LN / cRSA_SYM);%%%%%%%%%Ϊʲô��fix������Ҫ���нضϵ�������ô�죿
% % NcodeRSA=zeros(Zn, cRSA_SYM);
% % for i=1:Zn
% %     temp=codeRSA((i-1)*cRSA_SYM+ 1:i * cRSA_SYM);
% %     if (temp == (dec2bin(zeros(1,cRSA_SYM)))');
% %        break
% %     else
% %        NcodeRSA(i,:)=temp;
% %     end
% % end
% % NcodeRSA=char(NcodeRSA+48);
% % NcodeRSA=bin2dec(NcodeRSA);
% % % NcodeRSA=char(NcodeRSA);
% % NcodeRSA=NcodeRSA';
NcodeRSA = codeRSA;
Mcode = dRSA(NcodeRSA, d, n);
% % LNRSA=length(NcodeRSA);
% % for NK=1:LNRSA
% %     prex2=NcodeRSA(1,NK);
% %     X2=prex2^d;
% %     M=mod(X2,n);
% %     Mcode(1,NK)=double(M);
% % end
disp('3DES���õ���ԿΪ��')
Mcode







disp('����3DES���ܣ�')
K_des = dec2bin(Mcode);
K_des = double(K_des) - 48;
K_des = K_des';
K_des = K_des(:)';
K_des = [K_des, 1, 0];
K_des = K_des';
K_des = K_des(:);
K_des = K_des';

% mi_wen = fopen('miwen.txt');
% mi_char = fread(mi_wen);
mi_char = double(mi_char);
mi_char = dec2bin(mi_char);
mi_char = double(mi_char) - 48;
mi_char = mi_char';
mi_char = mi_char(:);

count_mi_64 = fix(length(mi_char) / 64);
for i_n3des = 1:count_mi_64
    miwen = mi_char((i_n3des - 1)*64 +1:i_n3des*64);
    miwen = miwen';
    min_des(i_n3des,:) = n3des(miwen, K_des);
end
min_des = min_des';
min_des = min_des(:);
min_des = min_des';
count_min_7 = fix(length(min_des) / 7);
for i_michar_minchar = 1:count_min_7
    min_char(i_michar_minchar, :) = min_des((i_michar_minchar-1)*7+1 : i_michar_minchar*7);
end
min_char = char(min_char + 48);
min_char = char(bin2dec(min_char));
disp('3DES���ܺ������Ϊ��')
min_char = min_char'
% dlmwrite('d_min.txt',min_char,'delimiter',' ','newline','pc')




