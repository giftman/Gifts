clear;
clc;
Image=imread('lena1.bmp');
%imshow(Image);
Imagesize=size(Image);
e=zeros(Imagesize);%%%%%%%%密文初始化
K2=3;
u=2;
K3='AAAAAB';
sum_k=sum(K3);
K3_1=K3(1);
r_k=dec2bin(K3_1);
r_k=str2num(r_k);
for i_k=2:length(K3)
         temp=K3(i_k);
         temp=dec2bin(temp);
         temp=str2num(temp);
   r_k=bitxor(r_k,temp);
end
r_k=num2str(r_k);
r_k=bin2dec(r_k);
a1=mod((sum_k/256),1);
u1=3+mod(round(1000*a1),30);
b1=r_k/256;
b_ta=3+mod(round(1000*b1),30);
%%%%%%%%%%%%%%%arnold seting%%%%%%%%%%
xc1=a1*b1;
yc1=(a1+b1)/2;
x=a1;

if  length(Imagesize)==3
  for layer=1:3 
      for row=1:Imagesize(1)
            for col=1:Imagesize(2)
                m=Image(row,col,layer);
                %%%%%系统a迭代
                for i_a=1:u1
                   x=1-u*x^2;
                end
                u_a=x;
                %%%%系统b迭代
                y=b1;
                for i_b=1:b_ta
                   y=K2*y^3+(1-K2)*y;
                end
                w_b=y;
                EncryptedImage(row,col)=mod((round(1000*u_a)+round(1000*w_b)+m),256);
                delta=mod(e(row,col),256);
                for i_arnold=1:3 %%%%%%%%%%Arnold 三次迭代
                     yc1=mod((yc1+delta),1);
                     xc1=xc1;
                end
                u1=mod((3+round(1000*xc1)),30);
                b_ta=mod((3+round(1000*yc1)),30);               
         end
      end
  end
   save Encrypted EncryptedImage;
   EncryptedImage;
   UEncryptedImage=uint8(EncryptedImage);
elseif   length(Imagesize)==2
   for row=1:Imagesize(1)
     for col=1:Imagesize(2)
         m=Image(row,col);
         m=double(m);
        %%%%%系统a迭代
        for i_a=1:u1
           x=1-u*x^2;
        end
        u_a=x;
        %%%%系统b迭代
        y=b1;
        for i_b=1:b_ta
           y=K2*y^3+(1-K2)*y;
        end
        w_b=y;
        EncryptedImage(row,col)=mod((round(1000*u_a)+round(1000*w_b)+m),256);
        delta=mod(EncryptedImage(row,col),256);
        for i_arnold=1:3 %%%%%%%%%%Arnold 三次迭代
             yc1=mod((yc1+delta),1);
             xc1=xc1;
        end
        u1=mod((3+round(1000*xc1)),30);
        b_ta=mod((3+round(1000*yc1)),30);
     end
   end
else
  disp('Error:this kind of image not supported!');
end
save Encrypted EncryptedImage;
   EncryptedImage;
   UEncryptedImage=uint8(EncryptedImage);
figure,
imshow(Image),title('Original Image');
figure(2),imshow(UEncryptedImage),title('Encrypted Image');
imwrite(UEncryptedImage,'ImageEncrypted.tif','tif');



    
    
    
    
    
    
    
    
    
    
    
    
