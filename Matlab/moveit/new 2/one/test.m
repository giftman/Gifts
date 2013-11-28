s1=imread('secret1.bmp');
s2=imread('secret2.bmp');
s3=imread('secret3.bmp');
f=imread('lsb_embedded.bmp');
weizhi=1;
f(:,:, 1)=bitset(f(:,:, 1),weizhi,s1(:,:));
f(:,:, 2)=bitset(f(:,:, 2),weizhi,s2(:,:));
f(:,:, 3)=bitset(f(:,:, 3),weizhi,s3(:,:));
imshow(f);
imwrite(s,'test1.bmp')