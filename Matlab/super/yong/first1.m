clear all
close all
clc;
tic;
Image=imread('lena.bmp');
%imshow(Image);
Imagesize=size(Image);
a=[1 1;1 2];
K1=4;
u=2;
K2='2hjkh#$$^t%h&fjyjou';
sum_k=sum(K2);
r_k=K2(1);
r_k=dec2bin(r_k,8);
r_k=uint8(r_k)-48;
for i_k=2:length(K2)
         temp=K2(i_k);
         temp=dec2bin(temp,8);
         temp=uint8(temp)-48;
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
                m=double(m);
                %%%%%系统a迭代
                for i_a=1:u1
                   x=1-u*x^2;
                end
                u_a=x;
                %%%%系统b迭代
                y=b1;
                for i_b=1:b_ta
                   y=K1*y^3+(1-K1)*y;
                end
                w_b=y;
               EncryptedImage(row,col,layer)=mod((round(1000*u_a)+round(1000*w_b)+m),256);
               delta=EncryptedImage(row,col,layer)/256;
                   yc1=mod((yc1+delta),1);
                     xc1=xc1;
                for i_arnold=1:3 
                        ans=[xc1;yc1];
                        ans=mod(a*ans,1);
                        xc1=ans(1);
                        yc1=ans(2);
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
              y=K1*y^3+(1-K1)*y;
          end
          w_b=y;
               EncryptedImage(row,col)=mod((round(1000*u_a)+round(1000*w_b)+m),256);
               delta=EncryptedImage(row,col)/256;
               yc1=mod((yc1+delta),1);
               xc1=xc1;
                for i_arnold=1:3 
                        ans=[xc1;yc1];
                        ans=mod(a*ans,1);
                        xc1=ans(1);
                        yc1=ans(2);
                end
        u1=3+mod(round(1000*xc1),30);
        b_ta=3+mod(round(1000*yc1),30);
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
figure(2),imshow(UEncryptedImage),title('Encryption Image');
imwrite(UEncryptedImage,'ImageEncrypted.tif','tif');
toc;


    
    
    
    
    
    
    
    
    
    
    
    
