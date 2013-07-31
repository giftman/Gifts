function EncrytTime=Encrytion(string, key)
% Copyrights  Reserved by Y.-G, Wang
% Version 1.0, 01-06-2010
start=cputime;
iTimes=key;
file1=dir(strcat(string, '*.bmp'));
[m, n]=size(file1);
for i=1:m
    x=imread(strcat(string, file1(i).name));
    [row, col, dim]=size(x);
    OutImg=uint8(zeros(row,col,dim));
    TempImg=x;
    for j=1:iTimes % 调用次数
      for dimn=1:dim
          for u=1:row
                for v=1:col
                ax=mod((u-1)+(v-1),row)+1;    % [1 1; 2 3] % ensure ad-bc = 1;去看看arnold 置乱的数学表达公式
                 ay=mod(2*(u-1)+3*(v-1), col)+1;
                 OutImg(ax,ay, dimn)=TempImg(u,v,dimn);
                 end
            end
       end
         TempImg=OutImg;
    end
    imwrite(OutImg, strcat(string, file1(i).name));
end

file2=dir(strcat(string, '*.jpg'));

[m, n]=size(file2);
for i=1:m
    x=imread(strcat(string,file2(i).name));
    [row, col, dim]=size(x);
    OutImg=uint8(zeros(row,col,dim));
    TempImg=x;
    for j=1:iTimes % 调用次数
         for dimn=1:dim
          for u=1:row
            for v=1:col
               
                 ax=mod((u-1)+(v-1),row)+1;    % [1 1; 2 3] % ensure ad-bc = 1;去看看arnold 置乱的数学表达公式
                 ay=mod(2*(u-1)+3*(v-1), col)+1;
                 OutImg(ax,ay, dimn)=TempImg(u,v,dimn);
                 end
            end
         end
         TempImg=OutImg;
    end
    imwrite(OutImg,strcat(string, file2(i).name), 'quality', 100);
end

EncrytTime=cputime-start;



