clear; clc
load('StuFaceLab.mat');
filelist=dir('*.bmp');
inFilename = filelist.name;
% only accept color bmp face, and arbitrary shape size
testface = imread(inFilename);
testface = rgb2gray(testface);
testface = imresize(testface, [128 128], 'bicubic');
testface = double(testface(:));
% basic information
% dim=size(Iv,1);
% tal=size(Iv,2);
% class=size(Iv,3);

dim=size(StuFaceLab,1);
tal=size(StuFaceLab,2);
class=size(StuFaceLab,3);

ell=2; % ell training sample;
ellsample=1; % ellsample test sample;
t=1e7; % Similarity matrix 的参数

order=1;  
dita=1e7; 
NumTotal=ell*class;
lpp=NumTotal-class;
lda=class-1;
polynomial=1;
pca=40;
%------------------- step 1     KPCA       ------------------------------%
Itr=zeros(dim,ell,class);  % Training sample feature vector
for classnum=1:class
    for e=1:ell
%         Itr(:,e,classnum)=Iv(:,e,classnum);  %
          Itr(:,e,classnum)=StuFaceLab(:,e,classnum);  %
    end    
end

% It=zeros(dim,ellsample,class);% Testing sample feature vector
% for classnum=1:class
%     for e=1:ellsample
%         It(:,e,classnum)=Iv(:,e+ell,classnum);  %
%     end    
% end

%----------------------------------------------------------------%
%   倒入向量 Iv(dim,ell)
%   样本类数  class
Imean=zeros(dim,1);
for classnum=1:class
    for i=1:ell
        Imean=Imean+Itr(:,i,classnum); 
    end
end
Imean=(1/(ell*class))*Imean;                       %求平均向量
Q=zeros(dim,ell*class);
for classnum=1:class
    for num=1:ell
        Q(:,num+(classnum-1)*ell)=Itr(:,num,classnum)-Imean(:,1);
    end
end
R=zeros(ell*class,ell*class);
R=Q'*Q;    % R's size is ell * ell
d=rank(R);

d=pca;


[U,L]=eigs(R,d,'LM');  % 求出 R 的eigenvector and eigenvalue
Wpca=zeros(dim,d);
for p=1:d
    Wpca(:,p)=(1/(sqrt(L(p,p))))*Q*U(:,p);
end
%% 程序至此得到了线形变换的矩阵  Wpca  .
%----------------------------------------------------------------%
Iy=zeros(d,ell,class); % training feature vector  %   
for classnum=1:class
    for num=1:ell
        Y=zeros(d,1);
        Iy(:,num,classnum)=Wpca'*Itr(:,num,classnum);
    end
end
% -------------------------------------------------------------------------

% we only recognition one face(i.e.,testface) in certain realtime and interactive manner 
% commented below by Y.G.Wang
% Tldalpp=zeros(d,ellsample,class);
% for classnum=1:class
%     for num=1:ellsample
%         Tldalpp(:,num,classnum)=Wpca'*It(:,num,classnum);
%     end
% end

%%%%%-----------------------------------------------%%%%%
% dimension=size(Tldalpp,1);
% % --------------------------------------算法性能测试----------------------------------------%
% r=zeros(ellsample,ellsample); 
% CorrectMatrix=zeros(1,class*ellsample);
% Glda=zeros(class,ellsample, class);

X=Wpca'*testface; % begin recognition
% for cl=1:class
%     for img=1:ellsample        %从此处到程序结束都为循环体
        
        
        %---------------------------循环体开始-------------------------------%
        
%       X=Tldalpp(:,img,cl);                     % X   input sample vector            %
        %以下为改进算法, 求每个类的 Z1 的平均值
%         Iymean=zeros(dimension,class); 
        Iymean=zeros(d,class); % because there two training face, revised by Y.G.Wang
        for classnum=1:class              % Z1 :  the mean of Z1
            for i=1:ell
                Iymean(:,classnum)=Iymean(:,classnum)+Iy(:,i,classnum); 
            end
            Iymean(:,classnum)=(1/ell)*Iymean(:,classnum);
        end
        %-------------------------进行匹配－－－－－－－－－－－－－－－－－－－%
        %----------------此处可以进行修改，利用其他simlarity measure------------%
        
        G2=zeros(1,class); 
        
        for classnum=1:class   
            G2(1,classnum)=(X'*Iymean(:,classnum))/(norm(X)*norm(Iymean(:,classnum)));      
        end
%         Glda(:,img,cl)=G2';
%         Glda(:,1,cl)=G2';
        Sclass=max(G2);
        
        %---------------得出最后的结果－－－－－－－－－－－－－－－－－－－－－%
        for classnum=1:class   
            if Sclass==G2(1,classnum)
                lastresult=classnum;
            end   
        end
        clc
        if Sclass > 0.97
            fprintf('此脸在本库中，且是学号：%d\n', lastresult);
        else
            fprintf('此脸不在本库中！\n');
        end
        
        
%         lastresult
        %---------------进行最后结果的评估  -----------------%
        
%         if lastresult==cl
%             CorrectMatrix(1,img+(cl-1)*ellsample)=1;% 如果正确，则置为 1；否则，保持不变为0；
%         end
%         
%         rate=sum(CorrectMatrix)/(class*ellsample);
%         
%     end  % for img=1:ellsample    
% end


% rate



