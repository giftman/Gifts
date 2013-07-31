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
t=1e7; % Similarity matrix �Ĳ���

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
%   �������� Iv(dim,ell)
%   ��������  class
Imean=zeros(dim,1);
for classnum=1:class
    for i=1:ell
        Imean=Imean+Itr(:,i,classnum); 
    end
end
Imean=(1/(ell*class))*Imean;                       %��ƽ������
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


[U,L]=eigs(R,d,'LM');  % ��� R ��eigenvector and eigenvalue
Wpca=zeros(dim,d);
for p=1:d
    Wpca(:,p)=(1/(sqrt(L(p,p))))*Q*U(:,p);
end
%% �������˵õ������α任�ľ���  Wpca  .
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
% % --------------------------------------�㷨���ܲ���----------------------------------------%
% r=zeros(ellsample,ellsample); 
% CorrectMatrix=zeros(1,class*ellsample);
% Glda=zeros(class,ellsample, class);

X=Wpca'*testface; % begin recognition
% for cl=1:class
%     for img=1:ellsample        %�Ӵ˴������������Ϊѭ����
        
        
        %---------------------------ѭ���忪ʼ-------------------------------%
        
%       X=Tldalpp(:,img,cl);                     % X   input sample vector            %
        %����Ϊ�Ľ��㷨, ��ÿ����� Z1 ��ƽ��ֵ
%         Iymean=zeros(dimension,class); 
        Iymean=zeros(d,class); % because there two training face, revised by Y.G.Wang
        for classnum=1:class              % Z1 :  the mean of Z1
            for i=1:ell
                Iymean(:,classnum)=Iymean(:,classnum)+Iy(:,i,classnum); 
            end
            Iymean(:,classnum)=(1/ell)*Iymean(:,classnum);
        end
        %-------------------------����ƥ�䣭������������������������������������%
        %----------------�˴����Խ����޸ģ���������simlarity measure------------%
        
        G2=zeros(1,class); 
        
        for classnum=1:class   
            G2(1,classnum)=(X'*Iymean(:,classnum))/(norm(X)*norm(Iymean(:,classnum)));      
        end
%         Glda(:,img,cl)=G2';
%         Glda(:,1,cl)=G2';
        Sclass=max(G2);
        
        %---------------�ó����Ľ��������������������������������������������%
        for classnum=1:class   
            if Sclass==G2(1,classnum)
                lastresult=classnum;
            end   
        end
        clc
        if Sclass > 0.97
            fprintf('�����ڱ����У�����ѧ�ţ�%d\n', lastresult);
        else
            fprintf('�������ڱ����У�\n');
        end
        
        
%         lastresult
        %---------------���������������  -----------------%
        
%         if lastresult==cl
%             CorrectMatrix(1,img+(cl-1)*ellsample)=1;% �����ȷ������Ϊ 1�����򣬱��ֲ���Ϊ0��
%         end
%         
%         rate=sum(CorrectMatrix)/(class*ellsample);
%         
%     end  % for img=1:ellsample    
% end


% rate



