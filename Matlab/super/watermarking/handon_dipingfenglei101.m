file1=dir(strcat('F:\Study\tuku\bmp_100\', '*.bmp'));%%读入101个经典图像所在目录图像信息
% file1=dir(strcat('F:\Study\tuku\bmp_565\', '*.bmp'));读入565个生活图像所在目录图像信息
[m, n]=size(file1);
num_dipin=zeros(1,m);
num_zhongpin=zeros(1,m);
for i=1:m
    x=imread(strcat('F:\Study\tuku\bmp_100\', file1(i).name));
    [row, col, dim]=size(x);
    photo_l=row*col;
    fun1=@dct2;%%%分割图像进行二维DCT变换
    J1=blkproc(x,[row col],fun1);
%%%%%%%%%将数据降序排列，将低、中频数据记录%%%%%%%%%%%%
    J_num= sort(abs(J1(:)'), 'descend');
    num_dipin(i)=J_num(round(photo_l/3));
    num_zhongpin(i)=J_num(round(2*photo_l/3));
end
save num_dipin num_dipin
save num_zhongpin num_zhongpin
%%%%%%%计算低中频算术平均（去除前后五个相差最大的数据）%%%%%
sum_dipin=0;
J_dipin=sort(num_dipin, 'descend');
for j=6:m-5
    sum_dipin=sum_dipin+J_dipin(j);
end
result_dipin=sum_dipin/(m-10);
sum_zhongpin=0;
J_zhongpin=sort(num_zhongpin, 'descend');
for j=6:m-5
    sum_zhongpin=sum_zhongpin+J_zhongpin(j);
end
result_zhongpin=sum_zhongpin/(m-10);
    