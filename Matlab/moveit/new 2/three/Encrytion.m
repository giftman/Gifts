function EncryTime=Encrytion(string,key);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Copyrights Reserved by yellow
%%%%%%%%%Version 1.0,2010.06.02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start=cputime;
iTimes=key;
file1=dir(strcat(string,'*.bmp'));
[m,n]=size(file1);
for i=1:m
    x=imread(strcat(string,file1(i).name));
    [row,col,dim]=size(x);
    outImg=uint8(zeros(row,col,dim));
    temp=x;
    for j=1:iTimes % ���ô���
         for dimnum=1:dim
            for u=1:row
                 for v=1:col
                  %  temp=tempImg(u,v);
                     ax=mod((u-1)+(v-1),row)+1;    % [1 1; 2 3] % ensure ad-bc = 1;ȥ����arnold ���ҵ���ѧ��﹫ʽ
                     ay=mod(2*(u-1)+3*(v-1),col)+1;
                     outImg(ax,ay,dimnum)=temp(u,v,dimnum);
                end
            end
         end
         tempImg=outImg;
    end
imwrite(outImg,strcat(string,file1(i).name));
end




file2=dir(strcat(string,'*.jpg'));
[m,n]=size(file2);
for i=1:m
    x=imread(strcat(string,file2(i).name));
    [row,col,dim]=size(x);
    outImg=uint8(zeros(row,col,dim));
    temp=x;
    for j=1:iTimes % ���ô���
         for dimnum=1:dim
            for u=1:row
                 for v=1:col
                  %  temp=tempImg(u,v);
                     ax=mod((u-1)+(v-1),row)+1;    % [1 1; 2 3] % ensure ad-bc = 1;ȥ����arnold ���ҵ���ѧ��﹫ʽ
                     ay=mod(2*(u-1)+3*(v-1),col)+1;
                     outImg(ax,ay,dimnum)=temp(u,v,dimnum);
                end
            end
         end
         tempImg=outImg;
    end
imwrite(outImg,strcat(string,file2(i).name));
end


stop=cputime;
EncryTime=stop-start
