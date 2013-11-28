% 读取载体图像
iCover = imread('lena.bmp');
dCover = double(iCover);
dOrigCover = dCover;
Mc=size(iCover,1);	% 高度
Nc=size(iCover,2);	% 宽度

% 读取水印图像
iWatermark = imread('zhongkai.bmp');	
dWatermark = double(iWatermark);
Mm=size(dWatermark,1);
Nm=size(dWatermark,2);

% 将水印图像转变为一维数组
dWatermarkVector=round(reshape(dWatermark,Mm*Nm,1)./256);

% 读取秘钥
file_name='cfbw.bmp';
key=double(imread(file_name))./256;
% rand('state',key); % 根据密钥生成随机数种子
h = waitbar(0,'Embedding, please wait...');
% haar小波变换
[cA1,cH1,cV1,cD1] = dwt2(dCover,'haar');

% 扩频叠加水印
iLength = length(dWatermarkVector);
for kk=1:iLength
    pn_sequence_h=round(2*(rand(Mc/2,Nc/2)-0.5));
    pn_sequence_v=round(2*(rand(Mc/2,Nc/2)-0.5));
    
    if (dWatermarkVector(kk) == 0)
        cH1=cH1+k*pn_sequence_h;
        cV1=cV1+k*pn_sequence_v;
    end
    waitbar(kk/iLength,h);
end
close(h);

% 逆小波变换
dEmbed = idwt2(cA1,cH1,cV1,cD1,'haar',[Mc,Nc]); 

% 保存嵌入了水印的图像
uEmbed = uint8(dEmbed);
imwrite(uEmbed,'~dwt.bmp','bmp');