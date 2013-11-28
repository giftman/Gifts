% ��ȡ����ͼ��
iCover = imread('lena.bmp');
dCover = double(iCover);
dOrigCover = dCover;
Mc=size(iCover,1);	% �߶�
Nc=size(iCover,2);	% ���

% ��ȡˮӡͼ��
iWatermark = imread('zhongkai.bmp');	
dWatermark = double(iWatermark);
Mm=size(dWatermark,1);
Nm=size(dWatermark,2);

% ��ˮӡͼ��ת��Ϊһά����
dWatermarkVector=round(reshape(dWatermark,Mm*Nm,1)./256);

% ��ȡ��Կ
file_name='cfbw.bmp';
key=double(imread(file_name))./256;
% rand('state',key); % ������Կ�������������
h = waitbar(0,'Embedding, please wait...');
% haarС���任
[cA1,cH1,cV1,cD1] = dwt2(dCover,'haar');

% ��Ƶ����ˮӡ
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

% ��С���任
dEmbed = idwt2(cA1,cH1,cV1,cD1,'haar',[Mc,Nc]); 

% ����Ƕ����ˮӡ��ͼ��
uEmbed = uint8(dEmbed);
imwrite(uEmbed,'~dwt.bmp','bmp');