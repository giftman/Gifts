f=imread('F:\’’∆¨\’’∆¨\DSC01395.JPG');
gg=uint8(zeros(128*128,3));
for i=1:3
    g=imcrop(f);
    g=rgb2gray(g);
    g=imresize(g,[128 128],'bilinear');
    imwrite(g,strcat(int2str(i),'.bmp'))
    g=g(:);
    gg(:,i)=g;
end
save gg