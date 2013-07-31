function varargout = duimage(varargin)
% DUIMAGE M-file for duimage.fig
%      DUIMAGE, by itself, creates a new DUIMAGE or raises the existing
%      singleton*.
%
%      H = DUIMAGE returns the handle to a new DUIMAGE or the handle to
%      the existing singleton*.
%
%      DUIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DUIMAGE.M with the given input arguments.
%
%      DUIMAGE('Property','Value',...) creates a new DUIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before duimage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to duimage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help duimage

% Last Modified by GUIDE v2.5 14-May-2011 10:55:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @duimage_OpeningFcn, ...
                   'gui_OutputFcn',  @duimage_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before duimage is made visible.
function duimage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to duimage (see VARARGIN)

% Choose default command line output for duimage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes duimage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = duimage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J_num
global J1
global M
global N
[filename,pathname] = ...
   uigetfile({'*.bmp';'*.jpg';'*.gif'},'ѡ��ͼƬ');
str=[pathname filename];

im=imread(str);
[M N]=size(im);
axes(handles.axes1);
imshow(im)
fun1=@dct2;%%%�ָ�ͼ����ж�άDCT�任
J1=blkproc(im,[M N],fun1);
%%%%%%%%%�����ݽ�������%%%%%%%%%%%%
 J_num= sort(abs(J1(:)'), 'descend');
 addcount=length(find(J_num>19.9855));
 set(handles.edit1,'string',strcat( '����Ƕ���������Ϊ',int2str(addcount)))
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global zhongkai
global suiyin_M
global suiyin_N
[filename,pathname] = ...
   uigetfile({'*.bmp';'*.jpg';'*.gif'},'ѡ��ͼƬ');
str=[pathname filename];

zhongkai=imread(str);
[suiyin_M,suiyin_N]=size(zhongkai);
axes(handles.axes2);
handles.zhongkai=zhongkai;
imshow(zhongkai)

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% zhongkai=imresize(handle.zhongkai,[30 30],'bilinear');
global zhongkai
global J_num
global J1
global M
global N
global marksize
global MNm
global yuzhi
global J2
global a
global zhongkai_l
a=0.0573;
zhongkai=zhongkai(:);
zhongkai_l=length(zhongkai);
%%%%%%%%%%%%�����ݴ���%%%%%%%%%%
zhongkai_z=zhongkai';
mm_source=zhongkai_z;
MNm=zhongkai_l*8;
yuzhi=J_num(MNm+2);
% % %%%%%2��Ƶ׼����Ϣ%%%%
 c=[ 1 -1 -1 1 1 -1 -1 1];
 Signal=mm_source;
 %%%%%%%2��Ƶ+���%%%%%%%%
 SigSp=kron(Signal,c);
 %%%%%%%%%%%%
z=SigSp;
t=1;
%%%%%%%%%%%%%%%ˮӡ��ϢǶ��%%%%%%%%%%%%%
J11=J1;
for i=1:M
    for k=1:N
        if abs(J1(i,k))>yuzhi&&t<=MNm&&(i+k>2)
            J11(i,k)=J1(i,k)*(1+a*z(t));
            t=t+1;
        end
    end
end
marksize=t-1;
handles.marksize=marksize;
J2=IDCT2(J11);%%%��άDCT��任
imwrite(uint8(round(J2)),'ss_watermakered.bmp');
axes(handles.axes3);
 imshow(uint8(round(J2)));
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M
global N
global marksize
global MNm
global yuzhi
global suiyin_M
global suiyin_N
global J1
global a
global zhongkai_l
global yy
c=[ 1 -1 -1 1 1 -1 -1 1];
fun1=@dct2;
J3=blkproc(yy,[M N],fun1);
t=1;
for i=1:M
    for k=1:N
        if abs(J1(i,k))>yuzhi&&t<=marksize&&(i+k>2);
            mn(t)=(J3(i,k)-J1(i,k))/(a*J1(i,k));
            t=t+1;
        end
    end
end
% %%%%%%%%%%2���յ������ݽ���أ�����%%%%
 RecSig=mn;
 De_Spr=RecSig;
  for i=1:zhongkai_l
          De_Spr(8*(i-1)+1:8*i)=RecSig(8*(i-1)+1:8*i).*c;
  end
 SigDeCorr(1:zhongkai_l)=0;
  for i=1:zhongkai_l
         SigDeCorr(i)=sum(De_Spr(8*(i-1)+1:8*i))/8;
 end
 Rec_Data=SigDeCorr;
     for i=1:zhongkai_l
         if (SigDeCorr(i)>0.5)
             Rec_Data(i)=1;
         else
              Rec_Data(i)=0;
         end
     end
%%%%%%%%%%%%��ˮӡͼ��ԭ%%%%%
zhongkaiback=zeros(suiyin_M,suiyin_N);
for i=1:suiyin_M
    for k=1:suiyin_N
        zhongkaiback(i,k)=Rec_Data(1,((i-1)*suiyin_M+k));
    end
end
zhongkaiback=zhongkaiback';
axes(handles.axes4);
imshow(zhongkaiback);


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global yy
global J2
J2=imread('ss_watermakered.bmp');
str=get(hObject,'string');
axes(handles.axes5);
switch str
    case'0'
    %%%%%(1)�Ŵ������Ĳ���������ȡ֮ǰҪ����С������
    yy=J2;
    imshow(yy);
    case'1'
    %%%%%(1)�Ŵ������Ĳ���������ȡ֮ǰҪ����С������
    xxx1=imresize(J2,2,'bicubic');
    imshow(xxx1);
    xxx2=imresize(xxx1,1/2,'bicubic');
    yy=double(xxx2);

    case'2'
    %%%(1)�Ŵ�4���Ĳ���������Ȼ��ȡ֮ǰҪ����С4����
    xxx1=imresize(J2,4,'bicubic');
    imshow(xxx1);
    xxx2=imresize(xxx1,1/4,'bicubic');
    yy=double(xxx2);

%(2)��С1/4�Ĳ���
    case'3'
    xxx1=imresize(J2,3/4,'bicubic');
    imshow(xxx1);
    xxx2=imresize(xxx1,4/3,'bicubic');
    yy=double(xxx2);

    case'4'
    xxx1=imresize(J2,2/4,'bicubic');
    imshow(xxx1);
    xxx2=imresize(xxx1,4/2,'bicubic');
    yy=double(xxx2);

%3*3�����ͨ�˲�
    case'5'
   B=(1/9)*ones(3,3);
   xxx2=filter2(B,J2);
   imshow(xxx2,[]);
    yy=double(xxx2);

%4����ƽ��
    case'6'
   B=[0 1 0;1 0 1;0 1 0]*(1/4);
   xxx2=filter2(B,J2);
   imshow(xxx2,[]);
    yy=double(xxx2);

%8����ƽ��
    case'7'
   B=[1 1 1;1 0 1;1 1 1]*(1/8);
   xxx2=filter2(B,J2);
   imshow(xxx2,[]);
    yy=double(xxx2);

%��7��������ֵ�˲�
    case'8'
    xxx2=medfilt2(J2);
    imshow(xxx2,[]);
    yy=double(xxx2);

%(8)��ת
    case'9'
  xxx2= imrotate(J2, -180);
  imshow(xxx2);
  xxx2= imrotate(xxx2, 180);
  yy=double(xxx2);

%%(8)�ü�
    case'10'
    for i=60-44:60+45
        for j=60-45:60+44
            J2(i,j)=0;
        end
    end
    imshow(J2);
    yy=double(J2);
    
    case'11'
    for i=70-64:70+63
        for j=70-64:70+63
            J2(i,j)=0;
        end
    end
    imshow(J2);
    yy=double(J2);

%��12����˹������
    case'12'
    yy=imnoise(uint8(round(J2)),'gaussian',0,0.0006);%��˹������
    imshow(yy);
end


% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)