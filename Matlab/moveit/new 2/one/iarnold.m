%function [outImg]=iarnold(inImg,iTimes)
inImg=imread('permuted_secret1.bmp');
iTimes=21;
[iH iW]=size(inImg);
if iH ~= iW % 必须是正方形
    error('The cover must be a square !');
    return;
end
outImg=logical(zeros(iH,iW));
tempImg=inImg;
for i=1:iTimes % 调用次数
        for u=1:iH
            for v=1:iW
                temp=tempImg(u,v);
                ax=mod(3*(u-1)-(v-1),iW)+1; % [1 1; 2 3] , ensure ad-bc = 1
                ay=mod((v-1)-2*(u-1),iW)+1;
%                 ax=mod(2*u-v-1,iW)+1;
%                 ay=mod(v-u,iW)+1;
                % ax=mod((u-1)+(v-1),iW)+1;  Fibonacci变换置乱
                % ay=mod((u-1),iW)+1;
                outImg(ax,ay)=temp;
            end
        end
      tempImg=outImg;
end
outImg=tempImg;
figure, imshow(outImg);
title('decoded');
