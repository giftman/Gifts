close all    %��һ����40
clear all
clc
a=0.0667;
simsave=zeros(1,13);
PSNRsave=zeros(1,13);
for numsave=1:12
attack_style=numsave;
attack_strength=1;
%%%%%%%%%%%%%����ԭʼ����ͼ��%%%%%%%%%%%
[x,map]=imread('lena512512.bmp');
[row,col]=size(x);
M=row;
N=col;
MN=col*row;
x_source=x;
fun1=@dct2;%%%�ָ�ͼ����ж�άDCT�任
J1=blkproc(x,[512 512],fun1);
%%%%%%%%%�����ݽ�������%%%%%%%%%%%%
 J_num= sort(abs(J1(:)'), 'descend');
%%%%%%%%%%%%%����ˮӡͼ��%%%%%%%%%%%
zhongkai=imread('zhongkai.bmp');
% zhongkai=imresize(zhongkai,[30 30],'bilinear');
[suiyin_M,suiyin_N]=size(zhongkai);
zhongkai_source=zhongkai;
zhongkai=zhongkai(:);
zhongkai_l=length(zhongkai);
zhongkai2=zeros(zhongkai_l,1);
%%%%%%%%%%%%�����ݺ��油��%%%%%%%%%%
zhongkai_z=zhongkai';
mm_source=zhongkai_z;
mm=mm_source;
MNm=zhongkai_l*8;
yuzhi=J_num(MNm+2);
% % %%%%%2��Ƶ׼����Ϣ%%%%
 c=[ 1 -1 -1 1 1 -1 -1 1];
 Signal=mm_source;
 %%%%%%%2��Ƶ+���%%%%%%%%
 SigSp=kron(Signal,c);
 %%%%%%%%%%%%
z=SigSp;
t=1;
%%%%%%%%%%%%%%%ˮӡ��ϢǶ��%%%%%%%%%%%%%
J11=J1;
for i=1:M
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
%3*3�����ͨ�˲�
if attack_style==5
   B=(1/9)*ones(3,3);
   xxx2=filter2(B,J2);
    yy=double(xxx2);
end 
%4����ƽ��
if attack_style==6
   B=[0 1 0;1 0 1;0 1 0]*(1/4);
   xxx2=filter2(B,J2);
    yy=double(xxx2);
end 
%8����ƽ��
if attack_style==7
   B=[1 1 1;1 0 1;1 1 1]*(1/8);
   xxx2=filter2(B,J2);
    yy=double(xxx2);
end 

%��7��������ֵ�˲�
if attack_style==8
    xxx2=medfilt2(J2);
    yy=double(xxx2);
end
%(8)��ת
if attack_style==9
  xxx2= imrotate(J2, -90);
  xxx2= imrotate(xxx2, 90);
yy=double(xxx2);
end
%%(8)�ü�
if attack_style==10
    for i=60-44:60+45
        for j=60-45:60+44
            J2(i,j)=0;
        end
    end
    yy=double(J2);
end
if attack_style==11
    for i=70-64:70+63
        for j=70-64:70+63
            J2(i,j)=0;
        end
    end
    yy=double(J2);
end
%��12����˹������
if attack_style==12
    yy=imnoise(uint8(round(J2)),'gaussian',0,0.0006);%��˹������
end
if attack_style>12
    yy=J2;
end
J3=blkproc(yy,[512 512],fun1);
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
% %%%%%%%%%%2���յ������ݽ���أ�����%%%%
 RecSig=mn;
 De_Spr=RecSig;
  for i=1:zhongkai_l
          De_Spr(8*(i-1)+1:8*i)=RecSig(8*(i-1)+1:8*i).*c;
  end
 SigDeCorr(1:zhongkai_l)=0;
  for i=1:zhongkai_l
         SigDeCorr(i)=sum(De_Spr(8*(i-1)+1:8*i))/8;
 end
 Rec_Data=SigDeCorr;
     for i=1:zhongkai_l
         if (SigDeCorr(i)>0.5)
             Rec_Data(i)=1;
         else
              Rec_Data(i)=0;
         end
     end
%%%%%%%%%%%%��ˮӡͼ��ԭ%%%%%
zhongkaiback=zeros(suiyin_M,suiyin_N);
for i=1:suiyin_M
    for k=1:suiyin_N
        zhongkaiback(i,k)=Rec_Data(1,((i-1)*suiyin_M+k));
    end
end
zhongkaiback=zhongkaiback';
%%%%%��������Լ�¼������Ϣ%%%%
sim=(sum(zhongkaiback.*zhongkai_source))/(sum(zhongkaiback.*zhongkaiback));
imwrite(zhongkaiback, strcat(int2str(numsave), '.bmp'))
simsave(numsave)=sim;
PSNRsave(numsave)=PSNR;
end
save simsave simsave;
save PSNRsave PSNRsave