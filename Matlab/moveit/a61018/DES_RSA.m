function varargout = DES_RSA(varargin)
% DES_RSA M-file for DES_RSA.fig
%      DES_RSA, by itself, creates a new DES_RSA or raises the existing
%      singleton*.
%
%      H = DES_RSA returns the handle to a new DES_RSA or the handle to
%      the existing singleton*.
%
%      DES_RSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DES_RSA.M with the given input arguments.
%
%      DES_RSA('Property','Value',...) creates a new DES_RSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DES_RSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DES_RSA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DES_RSA

% Last Modified by GUIDE v2.5 11-Jun-2011 00:48:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DES_RSA_OpeningFcn, ...
                   'gui_OutputFcn',  @DES_RSA_OutputFcn, ...
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


% --- Executes just before DES_RSA is made visible.
function DES_RSA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DES_RSA (see VARARGIN)

% Choose default command line output for DES_RSA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DES_RSA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DES_RSA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));
%Check whether the input
% if (isempty(input))
%     set(hObject,'String','0')
% end
% guidata(h0bject,handles);
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Check whether the input
% if (isempty(input))
%     set(hObject,'String','0')
% end
% guidata(h0bject,handles);
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hgd =get (handles.edit1,'String');
hgd = dec2bin(hgd);
hgd = double(hgd) - 48;
hgd = hgd';
hgd = hgd(:)';
len_hgd = length(hgd);
c_x = ceil(len_hgd / 64);
hgd = [hgd, zeros(1, c_x*64 - len_hgd)];
mi_des = zeros(c_x, 64);
% disp('请输入16字节密钥(18个字母,纯数字必须要26个)，密钥要以单引号标注');
K_des = get (handles.edit3,'String');
K_des_RSA = double(K_des);
K_des = dec2bin(K_des_RSA);
K_des = double(K_des) - 48;
K_des = K_des';
K_des = K_des(:)';
K_des = [K_des, 1, 0];
K_des = K_des';
K_des = K_des(:);
K_des = K_des';
for i_3des = 1:c_x
    min = hgd((i_3des - 1)*64 + 1 : i_3des*64);
    mi_des(i_3des,:) = des(min, K_des);
end
%mi_des = char(mi_des + 48);%%%%%%%%切记不能先转为char，不然加解密有时不正确
mi_des = mi_des';
mi_des = mi_des(:);
len_mi = length(mi_des);
count_mi_7 = ceil(len_mi / 7);
mi_des = [mi_des', zeros(1, (7 - mod(len_mi, 7)))];
for i_btoc = 1:count_mi_7
    mi_char(i_btoc,:) = mi_des((i_btoc - 1)*7+1 : i_btoc*7);
end
mi_char = char(mi_char + 48);
mi_char = char(bin2dec(mi_char));
mi_char = mi_char';
mi_charo=mi_char;
save mi_char mi_char
set(handles.edit2,'string',mi_char)

codeRSA=[];
% % p=43;q=59;
% % n=p*q;
% % nn=(p-1)*(q-1);
% % e=sym('13');
% % d=sym('937');
% for i=1:nn
%     if mod((i*nn+1),e)==0
%         d=(i*nn+1)/e;
%     break
%     end
% end
disp('初始化RSA....');
disp('请对此系统进行设定，确定素数p,q,e');
p=str2num(get (handles.edit7,'String'));
q=str2num(get (handles.edit8,'String'));
n=p*q;
set(handles.edit9,'string',n)
A=(p-1)*(q-1);
e=str2num(get (handles.edit10,'String'));
g=gcd(A,e);
% if g~=1;
%     disp('刚输入的e与A不互素');
%     break;
% end
e=sym(e);
for d=1:A
    if mod(d*e,A)==1
        disp('d = '),disp(d);
        break;
    end
end
set(handles.edit11,'string',d)
d=sym(d);

%mRSA=[138 65 195 522];
codeRSA = eRSA(K_des_RSA, e, n);%%%%%%%%%%%%%RSA加密
% mRSA = K_des_RSA;
% LRSA=length(mRSA);
% for k=1:LRSA
%     prex1=mRSA(1,k);
%     X1=prex1^e;
%     C=mod(X1,n);
%     codeRSA(1,k)=double(C);
% end
% % codeRSA=dec2bin(codeRSA);
% % codeRSA=double(codeRSA)-48;
% % cRSA_sym = size(codeRSA);
% % cRSA_SYM = cRSA_sym(2);
% % codeRSA=codeRSA';
% % codeRSA=codeRSA(:);
% % codeRSA=codeRSA';
codeRSAo=codeRSA;
save codeRSA codeRSA
set(handles.edit12,'string',num2str(codeRSA))

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(hObject,'String');
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(hObject,'String');
%Check whether the input
% if (isempty(input))
%     set(hObject,'String','0')
% end
% guidata(h0bject,handles);
% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(hObject,'String');
%Check whether the input
% if (isempty(input))
%     set(hObject,'String','0')
% end
% guidata(h0bject,handles);
% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(hObject,'String');
%Check whether the input
% if (isempty(input))
%     set(hObject,'String','0')
% end
% guidata(h0bject,handles);
% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(hObject,'String');
%Check whether the input
% if (isempty(input))
%     set(hObject,'String','0')
% end
% guidata(h0bject,handles);
% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(hObject,'String');
%Check whether the input
% if (isempty(input))
%     set(hObject,'String','0')
% end
% guidata(h0bject,handles);
% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
close all


% --- Executes during object deletion, before destroying properties.
function edit2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
