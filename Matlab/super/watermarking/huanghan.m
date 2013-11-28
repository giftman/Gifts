clear all;
clc;
 
%����ʱ��
start_time=cputime;
figure(1);
 
%����ԭʼͼ��
subplot(1,2,1);
input=imread('lena.bmp');
imshow(input);
title('ԭʼͼ��');
 
%����ˮӡͼ��
subplot(1,2,2);
watermarked_image=imread('2011.jpg');
imshow(watermarked_image,[]);
title('ˮӡͼ��');
 
%��ɫ����
input=double(input);
watermarked_image=double(watermarked_image);
inputr=input(:,:,1);
watermarked_imager=watermarked_image(:,:,1);
inputg=input(:,:,2);
watermarked_imageg=watermarked_image(:,:,2);
inputb=input(:,:,3);
watermarked_imageb=watermarked_image(:,:,3);
  
%ˮӡͼ��R�ķֽ�
[Cwr,Swr]=WAVEDEC2(watermarked_imager,2,'haar');
 
%ͼ��R�ķֽ�
[Cr,Sr]=WAVEDEC2(inputr,2,'haar');
 
%ˮӡͼ��G�ķֽ�
[Cwg,Swg]=WAVEDEC2(watermarked_imageg,2,'haar');
 
%ͼ��R�ķֽ�
[Cg,Sg]=WAVEDEC2(inputg,2,'haar');
  
%ˮӡͼ��B�ķֽ�
[Cwb,Swb]=WAVEDEC2(watermarked_imageb,2,'haar');
 
%ͼ��B�ķֽ�
[Cb,Sb]=WAVEDEC2(inputb,2,'haar');
   
%��ȡˮӡС��ϵ��
%��ȡˮӡR��С��ϵ��
r=0.06;
for k=0:3
     whr(k+1,:)=Cwr(1+size(Cwr,2)/4+k*size(Cwr,2)/16:...
           size(Cwr,2)/4+(k+1)*size(Cwr,2)/16)-...
           Cr(1+size(Cr,2)/4+k*size(Cr,2)/16:...
           size(Cr,2)/4+(k+1)*size(Cr,2)/16);
     wvr(k+1,:)=Cwr(1+size(Cwr,2)/2+k*size(Cwr,2)/16:...
            size(Cwr,2)/2+(k+1)*size(Cwr,2)/16)-...
          Cr(1+size(Cr,2)/2+k*size(Cr,2)/16:...
           size(Cr,2)/2+(k+1)*size(Cr,2)/16);
     wdr(k+1,:)=Cwr(1+3*size(Cwr,2)/4+k*size(Cwr,2)/16:...
          3*size(Cwr,2)/4+(k+1)*size(Cwr,2)/16)-...
          Cr(1+3*size(Cr,2)/4+k*size(Cr,2)/16:...
         3*size(Cr,2)/4+(k+1)*size(Cr,2)/16);
end
whr=(whr(1,:)+whr(2,:)+whr(3,:)+whr(4,:))/(4*r);
wvr=(wvr(1,:)+wvr(2,:)+wvr(3,:)+wvr(4,:))/(4*r);
wdr=(wdr(1,:)+wdr(2,:)+wdr(3,:)+wdr(4,:))/(4*r);
war=(Cwr(1:size(Cwr,2)/16)-Cr(1:size(Cr,2)/16))/r;
 
%��ȡˮӡС��ϵ��
%��ȡˮӡG��С��ϵ��
g=0.03;
for k=0:3
     whg(k+1,:)=Cwg(1+size(Cwg,2)/4+k*size(Cwg,2)/16:...
           size(Cwg,2)/4+(k+1)*size(Cwg,2)/16)-...
            Cg(1+size(Cg,2)/4+k*size(Cg,2)/16:...
           size(Cg,2)/4+(k+1)*size(Cg,2)/16);
     wvg(k+1,:)=Cwg(1+size(Cwg,2)/2+k*size(Cwg,2)/16:...
            size(Cwg,2)/2+(k+1)*size(Cwg,2)/16)-...
          Cg(1+size(Cg,2)/2+k*size(Cg,2)/16:...
            size(Cg,2)/2+(k+1)*size(Cg,2)/16);
     wdg(k+1,:)=Cwg(1+3*size(Cwg,2)/4+k*size(Cwg,2)/16:...
           3*size(Cwg,2)/4+(k+1)*size(Cwg,2)/16)-...
           Cg(1+3*size(Cg,2)/4+k*size(Cg,2)/16:...
           3*size(Cg,2)/4+(k+1)*size(Cg,2)/16);
end
whg=(whg(1,:)+whg(2,:)+whg(3,:)+whg(4,:))/(4*g);
wvg=(wvg(1,:)+wvg(2,:)+wvg(3,:)+wvg(4,:))/(4*g);
wdg=(wdg(1,:)+wdg(2,:)+wdg(3,:)+wdg(4))/(4*g);
wag=(Cwg(1:size(Cwg,2)/16)-Cg(1:size(Cg,2)/16))/g;
 
%��ȡˮӡС��ϵ��
%��ȡˮӡB��С��ϵ��
b=0.12;
for k=0:3
    whb(k+1,:)=Cwb(1+size(Cwb,2)/4+k*size(Cwb,2)/16:...
            size(Cwb,2)/4+(k+1)*size(Cwb,2)/16)-...
            Cb(1+size(Cb,2)/4+k*size(Cb,2)/16:...
            size(Cb,2)/4+(k+1)*size(Cb,2)/16);
    wvb(k+1,:)=Cwb(1+size(Cwb,2)/2+k*size(Cwb,2)/16:...
            size(Cwb,2)/2+(k+1)*size(Cwb,2)/16)-...
           Cb(1+size(Cb,2)/2+k*size(Cb,2)/16:...
         size(Cb,2)/2+(k+1)*size(Cb,2)/16);
    wdb(k+1,:)=Cwb(1+3*size(Cwb,2)/4+k*size(Cwb,2)/16:...
           3*size(Cwb,2)/4+(k+1)*size(Cwb,2)/16)-...
         Cb(1+3*size(Cb,2)/4+k*size(Cb,2)/16:...
          3*size(Cb,2)/4+(k+1)*size(Cb,2)/16);
end
whb=(whb(1,:)+whb(2,:)+whb(3,:)+whb(4,:))/(4*b);
wvb=(wvb(1,:)+wvb(2,:)+wvb(3,:)+wvb(4,:))/(4*b);
wdb=(wdb(1,:)+wdb(2,:)+wdb(3,:)+wdb(4,:))/(4*b);
wab=(Cwb(1:size(Cwb,2)/16)-Cb(1:size(Cb,2)/16))/b;
 
%�ع�ˮӡͼ��
cwr=[war,whr,wvr,wdr];
swr(:,1)=[sqrt(size(war,2)),sqrt(size(war,2)),2*sqrt(size(war,2))];
swr(:,2)=[sqrt(size(war,2)),sqrt(size(war,2)),2*sqrt(size(war,2))];
wr = waverec2(cwr,swr,'haar');
   
cwg=[wag,whg,wvg,wdg];
swg(:,1)=[sqrt(size(wag,2)),sqrt(size(wag,2)),2*sqrt(size(wag,2))];
swg(:,2)=[sqrt(size(wag,2)),sqrt(size(wag,2)),2*sqrt(size(wag,2))];
wg=waverec2(cwg,swg,'haar');
   
cwb=[wab,whb,wvb,wdb];
swb(:,1)=[sqrt(size(wab,2)),sqrt(size(wab,2)),2*sqrt(size(wab,2))];
swb(:,2)=[sqrt(size(wab,2)),sqrt(size(wab,2)),2*sqrt(size(wab,2))];
wb=waverec2(cwb,swb,'haar');
 
%��R��G��B����
temp=size(wr);
    pic=zeros(temp(1),temp(2),3);
    for i=1:temp(1);
       for j=1:temp(2);
           pic(i,j,1)=wr(i,j);
           pic(i,j,2)=wg(i,j);
           pic(i,j,3)=wb(i,j);
       end
   end
output=uint8(round(pic));
 
%ת��Ϊuint8
watermark_image_uint8=uint8(output);
imwrite(watermark_image_uint8,'watermark.bmp','bmp');
figure(2);
imshow(watermark_image_uint8);
title('��ȡ����ˮӡ');
