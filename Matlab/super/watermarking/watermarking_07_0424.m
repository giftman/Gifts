close all    %ֱ�Ӽ���Ƶ
clear all
clc
yuzhi=80;
a=0.0667;
attack_style=1;
attack_strength=2;

%%%%%%%%%%%%%����ԭʼ����ͼ��%%%%%%%%%%%
[x,map]=imread('Lena_256.bmp');
[row,col]=size(x);
M=row;
N=col;
MN=col*row;
figure(1);image(x),colormap(map);
title('ԭʼͼ��','Fontsize',16,'color','black');
x_source=x;
fun1=@dct2;%%%�ָ�ͼ����ж�άDCT�任
J1=blkproc(x,[256 256],fun1);
%%%%%%%%%%%%%����ˮӡͼ��%%%%%%%%%%%
zhongkai=imread('zhongkai.bmp');
zhongkai=zhongkai(:);
zhongkai_l=length(zhongkai);
zhongkai2=zeros(zhongkai_l,1);
%%%%%%%%��������Ϊ1000��α���������Ϊˮӡ��Ϣ%%%%%%
% mm_source=normrnd(0,1,[1 zhongkai_l]);
% mm_source=randint(1,zhongkai_l);
% mm=mm_source;
%%%%%%%%%%%%�����ݺ��油��%%%%%%%%%%
zhongkai_z=zhongkai';
mm_source=[zhongkai_z,zeros(1,1000-zhongkai_l)];
mm=mm_source;
MNm=1000;
%%%��ӵ�%%%%�൱�ڽ�ˮӡ���������������
% for ii=1:MNm
%     if zhongkai(ii,1)==1
%         mm(ii)=mm(ii);
%     else
%         mm(ii)=-1;
%     end
% end
% % %%%%%2��Ƶ׼����Ϣ%%%%
 format compact;
 N_user=8;
 c=[1 1 1 1 1 1 1 1;
    1 1 1 1 -1 -1 -1 -1;
     1 1 -1 -1 -1 -1 1 1;
     1 1 -1 -1 1 1 -1 -1;
     1 -1 -1 1 1 -1 -1 1 ;
     1 -1 -1 1 -1 1 1 -1 ;
     1 -1 1 -1 -1 1 -1 1 ;
     1 -1 1 -1 1 -1 1 -1 ];
 Len_PN=length(c);
 Len_Data=125;
 Len_Chip=Len_PN*Len_Data;
 Signal=zeros(N_user,Len_Data);
 %%%%%%%2��Ƶ+���%%%%%%%%
 for i=1:N_user
     Signal(i,:)=mm(((i-1)*125+1):i*125);
 end
 for i=1:N_user
     SigSp(i,:)=kron(Signal(i,:),c(i,:));
 end
TranSig(1:Len_Chip)=0;
for i=1:N_user
     TranSig(1,:)= TranSig(1,:)+SigSp(i,:);
end
 %%%%%%%%%%%%
z=TranSig;
% z=mm;
num=1;
num1=1;
num2=1;
t=1;
%%%%%%%%%%%%%%%ˮӡ��ϢǶ��%%%%%%%%%%%%%
J11=J1;
for i=1:N
    for k=1:N
        if abs(J1(i,k))>yuzhi&&t<=MNm&&(i+k>2)
            J11(i,k)=J1(i,k)*(1+a*z(t));
            t=t+1;
        end
    end
end
marksize=t-1;
J2=IDCT2(J11);%%%��άDCT��任
imwrite(uint8(round(J2)),'ss_watermakered.bmp');
%%%%%%%%����ϳ��źŵķ�ֵ�����%%%%%%%%%%%
x_temp1=J2-double(x_source);
figure(10),imshow(uint8(round(100*x_temp1)));
imwrite((uint8(round(100*x_temp1))),'ss_chazhi.bmp')
x_temp2=x_temp1(:);
x_temp3=abs(x_temp2);
x_temp4=x_temp3'*x_temp3;
d_embed=x_temp4/(M*M);
SDR1=255*255/d_embed;
PSNR=10*log10(SDR1);

%%%%%%%%%%%%%%%%%%%%%%%%%%����%%%%%%%%%%%%%%%%%%%%%
J2=imread('ss_watermakered.bmp');
if attack_style==1
    %%%%%(1)�Ŵ������Ĳ���������ȡ֮ǰҪ����С������
    xxx1=imresize(J2,2,'bicubic');
    xxx2=imresize(xxx1,1/2,'bicubic');
    yy=double(xxx2);
end
if attack_style==2
    %%%(1)�Ŵ�4���Ĳ���������Ȼ��ȡ֮ǰҪ����С4����
    xxx1=imresize(J2,4,'bicubic');
    xxx2=imresize(xxx1,1/4,'bicubic');
    yy=double(xxx2);
end
%(2)��С1/4�Ĳ���
if attack_style==3
    xxx1=imresize(J2,3/4,'bicubic');
    xxx2=imresize(xxx1,4/3,'bicubic');
    yy=double(xxx2);
end
if attack_style==4
    xxx1=imresize(J2,2/4,'bicubic');
    xxx2=imresize(xxx1,4/2,'bicubic');
    yy=double(xxx2);
end
%3*3��������˲�
if attack_style==5
   B=(1/9)*ones(3,3);
   xxx2=filter2(B,J2);
    yy=double(xxx2);
end 
%4����ƽ��
if attack_style==6
   B=[0 1 0;1 0 1;0 1 0]*(1/4);
   xxx2=filter(B,J2);
    yy=double(xxx2);
end 
%8����ƽ��
if attack_style==7
   B=[1 1 1;1 0 1;1 1 1]*(1/8);
   xxx2=filter(B,J2);
    yy=double(xxx2);
end 

%��7��������ֵ�˲�
if attack_style==9
    %a1=input('Please input length of window al:');
    %b1=input('Please input length of window bl:');
a1=1;
b1=3;
xxx2=medfilt2(J2,[a1 b1]);
save a1 a1;
save b1 b1;
yy=double(xxx2);
end
%%(8)�ü�
if attack_style==10
    for i=128-44:128+45
        for j=128-45:128+44
            J2(i,j)=0;
        end
    end
    yy=double(J2);
end

if attack_style==11
    for i=128-64:128+63
        for j=128-64:128+63
            J2(i,j)=0;
        end
    end
    yy=double(J2);
end

if attack_style==12
    yy=imnoise(uint8(round(J2)),'gaussian',0,attack_strength);%��˹����
end

if attack_style==13
    imwrite(uint8(round(J2)),'jpeg_n.jpg','jpg','Quality',attack_strength);
    [yy,map]=imread('jpeg_n.jpg','jpg');
end
if attack_style>13
    yy=J2;
end
J3=blkproc(yy,[256 256],fun1);
%%��ȡˮӡ��Ϣ%%%
t1=zeros(MNm,1);
t0=zeros(MNm,1);
t=1;
for i=1:M
    for k=1:N
        if abs(J1(i,k))>yuzhi&&t<=marksize&&(i+k>2);
            mn(t)=(J3(i,k)-J1(i,k))/(a*J1(i,k));
            t=t+1;
        end
    end
end
% mn=round(mn);
% %%%%%%%%%%2���յ������ݽ���أ�����%%%%
 RecSig=mn;
 for j=1:N_user;
     for i=1:Len_Data
         De_Spr(j,Len_PN*(i-1)+1:Len_PN*i)=RecSig(Len_PN*(i-1)+1:Len_PN*i).*c(j,:);
     end
 end
 SigDeCorr(1:N_user,1:Len_Data)=0;
 for j=1:N_user
     for i=1:Len_Data
         SigDeCorr(j,i)=SigDeCorr(j,i)+sum(De_Spr(j,Len_PN*(i-1)+1:Len_PN*i))/Len_PN;
     end
 end
 for j=1:N_user;
     for i=1:Len_Data
         if (SigDeCorr(j,i)>0.5)
             Rec_Data(j,i)=1;
         else
              Rec_Data(j,i)=0;
         end
     end
 end
% for kk=1:zhongkai_l
%     if mn(kk)==-1
%         zhongkai2(kk)=1;
%     else
%         zhongkai2(kk)=0;
%     end
% end
 %%%%%%%%%%%%2�����ݻ�ԭ��һ��%%%%%
 for i=1:N_user
     mm(((i-1)*125+1):i*125)=Rec_Data(i,:);    
 end
 Rec_Data=Rec_Data(1:zhongkai_l);
%%%%%%%%%%%%��ˮӡͼ��ԭ%%%%%
zhongkai3=zeros(30,30);
for i=1:30
    for k=1:30
        zhongkai3(i,k)=mm(1,((i-1)*30+k));
    end
end
zhongkai3=zhongkai3';
figure,imshow(zhongkai3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%if marksize<MNm
%    mn(marksize+1:MNm)=mm(marksize+1:MNm);
%end
%%%%%���������%%%%
sim=(sum(mn(1:MNm).*mm_source(1:MNm)))/((sum(mm_source(1:MNm)))^0.5);