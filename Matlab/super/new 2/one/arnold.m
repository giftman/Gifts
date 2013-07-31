 clear all
 close all
 clc
%function [outImg]=arnold(inImg,iTimes)
inImg=imread('secret1.bmp');
figure(1), imshow(inImg);
title('original');
[iH iW]=size(inImg);
iTimes=19;
if iH ~= iW % ������������
    error('The cover must be a square !');
    return;
end

% outImg=uint8(zeros(iH,iW)); % for gray-scale image
outImg=logical(zeros(iH,iW));  % for binary image
tempImg=inImg;

for i=1:iTimes % ���ô���
         for u=1:iH
            for v=1:iW
                temp=tempImg(u,v);
                 ax=mod((u-1)+(v-1),iW)+1;    % [1 1; 2 3] % ensure ad-bc = 1;ȥ����arnold ���ҵ���ѧ��﹫ʽ
                 ay=mod(2*(u-1)+3*(v-1),iW)+1;
%                 ax=mod((u-1)+(v-1),iW)+1;  % [1 1; 1 2]
%                 ay=mod((u-1)+2*(v-1),iW)+1;
                % ax=mod((u-1)+(v-1),iW)+1;  Fibonacci�任����
                % ay=mod((u-1),iW)+1;
                outImg(ax,ay)=temp;
            end
         end
         tempImg=outImg;
end
outImg=tempImg;
figure(2), imshow(outImg);
title('permuted');
imwrite(outImg, 'permuted_secret1.bmp');


