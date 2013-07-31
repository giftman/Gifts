clear all
close all
clc
x=imread('DSC01395.JPG');
Face=zeros(128*128,33);
for i=24:33
    y=imcrop(x);
    y=rgb2gray(y);
    y=imresize(y, [128 128], 'bicubic');
    imwrite(y, strcat(int2str(i), '.bmp'));
    y=y(:);
    Face(:,i)=y;
end
save('Face.mat', Face);
    
    
    