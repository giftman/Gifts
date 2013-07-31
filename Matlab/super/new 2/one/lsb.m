close all
clear all
clc
x=imread('4257309022749135958.jpg');
x=imresize(x,[512 512],'bilinear');
[row,col]=size(x);
M=row;
N=col;
MN=col*row;
figure(1);imshow(x);
title('original','Fontsize',16,'color','blue');
x_source=x;
weizhi=1;
 attack_style=5;
%%%%%%%%%%%%%%%%%%%%读入原始隐密信息%%%%%%%%%%%%%%%%%%%%%%%%
secret1=imread('secret1.bmp');
secret2=imread('secret2.bmp');
secret3=imread('secret3.bmp');
% arnold permutation
[iH iW]=size(secret1);
iTimes=20;
if iH ~= iW % 必须是正方形
    error('The cover must be a square !');
    return;
end

outImg1=logical(zeros(iH,iW));  % for binary image
outImg2=logical(zeros(iH,iW)); 
outImg3=logical(zeros(iH,iW)); 
tempImg1=secret1;
tempImg2=secret2;
tempImg3=secret3;

for i=1:iTimes % 调用次数
         for u=1:iH
            for v=1:iW
                temp1=tempImg1(u,v);
                temp2=tempImg2(u,v);
                temp3=tempImg3(u,v);
                 ax=mod((u-1)+(v-1),iW)+1;    % [1 1; 2 3] % ensure ad-bc = 1;去看看arnold 置乱的数学表达公式
                 ay=mod(2*(u-1)+3*(v-1),iW)+1;
%                 ax=mod((u-1)+(v-1),iW)+1;  % [1 1; 1 2]
%                 ay=mod((u-1)+2*(v-1),iW)+1;
                % ax=mod((u-1)+(v-1),iW)+1;  Fibonacci变换置乱
                % ay=mod((u-1),iW)+1;
                outImg1(ax,ay)=temp1;
                outImg2(ax,ay)=temp2;
                outImg3(ax,ay)=temp3;
            end
         end
         tempImg1=outImg1;
         tempImg2=outImg2;
         tempImg3=outImg3;
end
outImg1=tempImg1;
outImg2=tempImg2;
outImg3=tempImg3;
% first secret information
for i=1:512
  for j=1:512
     if double(outImg1(i,j))==0
           w1(i,j)=0;
     else  
           w1(i,j)=1;
     end
  end
end
% second secret information
for i=1:512
  for j=1:512
     if double(outImg2(i,j))==0
           w2(i,j)=0;
     else  
           w2(i,j)=1;
     end
  end
end
% third secret information
for i=1:512
  for j=1:512
     if double(outImg3(i,j))==0
           w3(i,j)=0;
     else  
           w3(i,j)=1;
     end
  end
end

%%%%%%%%%%%%%水印信息的嵌入%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=x;
for i = 1:512
   for j = 1:512
      s(i,j, 1)=bitset(x(i,j, 1),weizhi,w1(i,j));
      s(i,j, 2)=bitset(x(i,j, 2),weizhi,w2(i,j));
      s(i,j, 3)=bitset(x(i,j, 3),weizhi,w3(i,j));
   end
end
figure(2), imshow(s);
title('embedded image');
imwrite(s,'lsb_embedded.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%开始攻击%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=imread('lsb_embedded.bmp');
J2 = s;
if attack_style == 1
%%%%(1) 放大两倍的操作，(当然提取之前要先缩小两倍)
xxx1 = imresize(J2,2,'bicubic');
xxx2 = imresize(xxx1,1/2,'bicubic');
yy = double(xxx2);
end
if attack_style == 2
%%%%(1) 放大4倍的操作，(当然提取之前要先缩小4倍)
xxx1=imresize(J2,4,'bicubic');
xxx2=imresize(xxx1,1/2,'bicubic');
yy = double(xxx2);
end
%%%%(2)缩小1/4的操作
if attack_style == 3
xxx1=imresize(J2,3/4,'bicubic');
xxx2=imresize(xxx1,4/3,'bicubic');
yy = double(xxx2);
end
if attack_style == 4
xxx1 = imresize(J2,2/4,'bicubic');
xxx2 = imresize(xxx1,4/2,'bicubic');
yy = double(xxx2);
end
%3*3空域低通滤波
if attack_style == 5
B=(1/9)*ones(3,3);
xxx2=imfilter(J2,B);
yy = double(xxx2);
end
%%%%4领域平均
if attack_style == 6
B = [0 1 0;1 0 1;0 1 0]*(1/4);
xxx2 = filter2(B,J2);
yy = double(xxx2);
end
%%%%8领域平均
if attack_style == 7
B = [1 1 1;1 0 1;1 1 1]*(1/8);
xxx2 = filter2(B,J2);
yy = double(xxx2);
end
%%%%%(7)窗口中值滤波
if attack_style == 8
xxx2 = medfilt2(J2); %%%默认3*3
yy = double(xxx2);
end
if attack_style == 9
% a1 = input('Please input length of window a1:');
% b1 = input('Please input length of window b1:');
a1 = 1;
b1 = 3;
xxx2 = medfilt2(J2,[a1,b1]);
save a1 a1;
save b1 b1;
yy = double(xxx2);
end
%%%(8)裁减
if attack_style == 10
for i=128-44:128 + 45
   for j = 128 - 45:128 + 44
       J2(i,j) = 0;
   end
end
yy = double(J2);
end
if attack_style == 11
for i =128-64:128 + 63
   for j = 128-64:128 + 63
     J2(i,j) = 0;
   end 
end
yy = double(J2);
end
if attack_style == 12
yy = imnoise(uint8(round(J2)),'gaussian',0,attack_strength); %高斯噪声
end
if attack_style == 13
   imwrite(uint8(round(J2)),'jpeg_n.jpg','jpg','Quality',attack_strength);
   [yy,map]=imread('jpeg_n.jpg','jpg');
end
if attack_style > 13
  yy = J2;
end
%%%%%%%%%%%%%%隐密信息的提取 %%%%%%%%%%%%%%%%%
for i = 1:512
   for j = 1:512 
     mm1(i,j) = bitget(uint8(yy(i,j, 1)),weizhi);
     mm2(i,j) = bitget(uint8(yy(i,j, 2)),weizhi);
     mm3(i,j) = bitget(uint8(yy(i,j, 3)),weizhi);
     % first secret
     if double(mm1(i,j)) ==1
        mm1(i,j) = 255;
     else
        mm1(i,j) = 0;
     end
     % second secret
      if double(mm2(i,j)) ==1
        mm2(i,j) = 255;
      else
        mm2(i,j) = 0;
      end
      % third secret
      if double(mm3(i,j)) ==1
        mm3(i,j) = 255;
      else
        mm3(i,j) = 0;
      end
     
   end
end
%%%%%%计算误码率%%%%%%%%%%%%%55
% err = sum(sum(xor(m,mm)))/256*256);

% inverse arnold permutation
% iTimes=21;
[iH iW]=size(mm1);
if iH ~= iW % 必须是正方形
    error('The cover must be a square !');
    return;
end
outImg1=logical(zeros(iH,iW));
outImg2=logical(zeros(iH,iW));
outImg3=logical(zeros(iH,iW));
tempImg1=mm1;
tempImg2=mm2;
tempImg3=mm3;
for i=1:iTimes % 调用次数
        for u=1:iH
            for v=1:iW
                temp1=tempImg1(u,v);
                temp2=tempImg2(u,v);
                temp3=tempImg3(u,v);
                ax=mod(3*(u-1)-(v-1),iW)+1; % [1 1; 2 3] , ensure ad-bc = 1
                ay=mod((v-1)-2*(u-1),iW)+1;
%                 ax=mod(2*u-v-1,iW)+1;
%                 ay=mod(v-u,iW)+1;
                % ax=mod((u-1)+(v-1),iW)+1;  Fibonacci变换置乱
                % ay=mod((u-1),iW)+1;
                outImg1(ax,ay)=temp1;
                outImg2(ax,ay)=temp2;
                outImg3(ax,ay)=temp3;
            end
        end
      tempImg1=outImg1;
      tempImg2=outImg2;
      tempImg3=outImg3;
end
outImg1=tempImg1;
outImg2=tempImg2;
outImg3=tempImg3;

figure(3), imshow(outImg1);
title('firth decoded secret');
figure(4), imshow(outImg2);
title('second decoded secret');
figure(5), imshow(outImg3);
title('third decoded secret');

% end all







