%Logistic map image encryption 用混沌对图像进行一级加密
clear;
clc;
tic;
Image=imread('grey.bmp');
imshow(Image);
Imagesize=size(Image);
x=zeros(prod(Imagesize)+1,1); 
z=zeros(prod(Imagesize)+1,1); 
l=zeros(prod(Imagesize),1); 
EncryptedImage=Image;
n=0;
u=2;    
x(1)=-0.5784; 
%以下开始图象加密
if  length(Imagesize)==3
  for layer=1:3 
      for row=1:Imagesize(1)
          for col=1:Imagesize(2)
              s=Image(row,col,layer);
              n=n+1;
              x(n+1)=1-u*x(n)^2;
              l(n)=mod(round(10000*x(n)),255);
              z(n+1)=bitxor(l(n),s);  
              EncryptedImage(row,col,layer)=z(n+1);                 
         end
      end
  end
   save Encrypted EncryptedImage;
   EncryptedImage;
   UEncryptedImage=uint8(EncryptedImage);
elseif   length(Imagesize)==2
   for row=1:Imagesize(1)
     for col=1:Imagesize(2)
         s=Image(row,col);
         n=n+1;
         x(n+1)=1-u*x(n)^2;
         l(n)=mod(round(10000*x(n)),255);%%%%%%%%%%256
         z(n+1)=bitxor(l(n),s);  
         EncryptedImage(row,col)=z(n+1);                 
     end
 end
   save Encrypted EncryptedImage;
   EncryptedImage;
   UEncryptedImage=uint8(EncryptedImage);
else
  disp('Error:this kind of image not supported!');
end
   
 figure(1);
imshow(Image);
title('原图像');
figure(2);
imshow(UEncryptedImage);
title('加密图像1');
imwrite(UEncryptedImage,'ImageEncrypted.tif','tif');
toc;



