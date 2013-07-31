close all
clear all
clc
yuzhi=80;
a=0.0667;
attack_style=5;
attack_strength=2;

%%%%%%%%%%%%%读入原始载体图像%%%%%%%%%%%
[x,map]=imread('Lena_256.bmp');
[row,col]=size(x);
M=row;
N=col;
MN=col*row;
figure(1);image(x),colormap(map);
title('原始图像','Fontsize',16,'color','black');
x_source=x;
fun1=@dct2;%%%分割图像进行二维DCT变换
J1=blkproc(x,[256 256],fun1);
%%%%%%%%%%%%%读入水印图像%%%%%%%%%%%
zhongkai=imread('zhongkai.bmp');
zhongkai=zhongkai(:);
zhongkai_l=length(zhongkai);
zhongkai2=zeros(zhongkai_l,1);
%%%%%%%%产生长度为1000的伪随机序列作为水印信息%%%%%%
% mm_source=normrnd(0,1,[1 zhongkai_l]);
mm_source=randint(1,zhongkai_l);
mm=mm_source;
MNm=zhongkai_l;
%%%添加的%%%%相当于将水印与随机序列作处理
for ii=1:MNm
    if zhongkai(ii,1)==1
        mm(ii)=mm(ii);
    else
        mm(ii)=-1;
    end
end
%%%%%%%%%%%%
z=mm;
num=1;
num1=1;
num2=1;
t=1;
%%%%%%%%%%%%%%%水印信息嵌入%%%%%%%%%%%%%
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
J2=IDCT2(J11);%%%二维DCT逆变换
imwrite(uint8(round(J2)),'ss_watermakered.bmp');
%%%%%%%%计算合成信号的峰值信噪比%%%%%%%%%%%
x_temp1=J2-double(x_source);
figure(10),imshow(uint8(round(100*x_temp1)));
imwrite((uint8(round(100*x_temp1))),'ss_chazhi.bmp')
x_temp2=x_temp1(:);
x_temp3=abs(x_temp2);
x_temp4=x_temp3'*x_temp3;
d_embed=x_temp4/(M*M);
SDR1=255*255/d_embed;
PSNR=10*log10(SDR1);

%%%%%%%%%%%%%%%%%%%%%%%%%%攻击%%%%%%%%%%%%%%%%%%%%%
J2=imread('ss_watermakered.bmp');
if attack_style==1
    %%%%%(1)放大两倍的操作，（提取之前要先缩小两倍）
    xxx1=imresize(J2,2,'bicubic');
    xxx2=imresize(xxx1,1/2,'bicubic');
    yy=double(xxx2);
end
if attack_style==2
    %%%(1)放大4倍的操作，（当然提取之前要先缩小4倍）
    xxx1=imresize(J2,4,'bicubic');
    xxx2=imresize(xxx1,1/4,'bicubic');
    yy=double(xxx2);
end
%(2)缩小1/4的操作
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
%3*3空域低能滤波
if attack_style==5
   B=(1/9)*ones(3,3);
   xxx2=filter2(B,J2);
    yy=double(xxx2);
end 
%4领域平均
if attack_style==6
   B=[0 1 0;1 0 1;0 1 0]*(1/4);
   xxx2=filter(B,J2);
    yy=double(xxx2);
end 
%8领域平均
if attack_style==7
   B=[1 1 1;1 0 1;1 1 1]*(1/8);
   xxx2=filter(B,J2);
    yy=double(xxx2);
end 

%（7）窗口中值滤波
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
%%(8)裁减
if attack_style==10
    for i=128-44:128+45
        for i=128-45:128+44
            J2(i,j)=0;
        end
    end
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
    yy=imnoise(uint8(round(J2)),'gaussian',0,attack_strength);%高斯噪声
end

if attack_style==13
    imwrite(uint8(round(J2)),'jpeg_n.jpg','jpg','Quality',attack_strength);
    [yy,map]=imread('jpeg_n.jpg','jpg');
end
if attack_style>13
    yy=J2;
end
J3=blkproc(yy,[256 256],fun1);
%%提取水印信息%%%
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
mn=round(mn);
for kk=1:zhongkai_l
    if mn(kk)==-1
        zhongkai2(kk)=1;
    else
        zhongkai2(kk)=0;
    end
end

%%%%%%%%%%%%将水印图像还原%%%%%
zhongkai3=zeros(30,30);
for i=1:30
    for k=1:30
        zhongkai3(i,k)=zhongkai2(((i-1)*30+k),1);
    end
end
zhongkai3=zhongkai3';
figure,imshow(zhongkai3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%if marksize<MNm
%    mn(marksize+1:MNm)=mm(marksize+1:MNm);
%end
%%%%%计算相关性%%%%
sim=(sum(mn(1:MNm).*mm(1:MNm)))/((sum(mm(1:MNm)))^0.5);