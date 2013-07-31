function varargout = NDES_RSA(varargin)
% NDES_RSA M-file for NDES_RSA.fig
%      NDES_RSA, by itself, creates a new NDES_RSA or raises the existing
%      singleton*.
%
%      H = NDES_RSA returns the handle to a new NDES_RSA or the handle to
%      the existing singleton*.
%
%      NDES_RSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NDES_RSA.M with the given input arguments.
%
%      NDES_RSA('Property','Value',...) creates a new NDES_RSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NDES_RSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NDES_RSA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NDES_RSA

% Last Modified by GUIDE v2.5 12-Jun-2011 00:36:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NDES_RSA_OpeningFcn, ...
                   'gui_OutputFcn',  @NDES_RSA_OutputFcn, ...
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


% --- Executes just before NDES_RSA is made visible.
function NDES_RSA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NDES_RSA (see VARARGIN)

% Choose default command line output for NDES_RSA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NDES_RSA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NDES_RSA_OutputFcn(hObject, eventdata, handles) 
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
global mi_char
global codeRSA
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=str2num(get (handles.edit9,'String'));
d=str2num(get (handles.edit11,'String'));


Mcode=[];
% nn=(p-1)*(q-1);
% e=sym('13');
% % d=sym('937');
% % LN=length(codeRSA);%开始转回来
% % Zn=fix(LN / cRSA_SYM);%%%%%%%%%为什么是fix，后面要是有截断的数据怎么办？
% % NcodeRSA=zeros(Zn, cRSA_SYM);
% % for i=1:Zn
% %     temp=codeRSA((i-1)*cRSA_SYM+ 1:i * cRSA_SYM);
% %     if (temp == (dec2bin(zeros(1,cRSA_SYM)))');
% %        break
% %     else
% %        NcodeRSA(i,:)=temp;
% %     end
% % end
% % NcodeRSA=char(NcodeRSA+48);
% % NcodeRSA=bin2dec(NcodeRSA);
% % % NcodeRSA=char(NcodeRSA);
% % NcodeRSA=NcodeRSA';
load codeRSA
NcodeRSA=codeRSA;
% NcodeRSA = get (handles.edit12,'String');
d = sym(d);
Mcode = dRSA(NcodeRSA, d, n);
% % LNRSA=length(NcodeRSA);
% % for NK=1:LNRSA
% %     prex2=NcodeRSA(1,NK);
% %     X2=prex2^d;
% %     M=mod(X2,n);
% %     Mcode(1,NK)=double(M);
% % end
disp('进行3DES解密：')
K_des = dec2bin(Mcode);
K_des = double(K_des) - 48;
K_des = K_des';
K_des = K_des(:)';
K_des = [K_des, 1, 0];
K_des = K_des';
K_des = K_des(:);
K_des = K_des';
% mi_char=get (handles.edit12,'String');
load mi_char
% mi_wen = fopen('miwen.txt');
% mi_char = fread(mi_wen);
mi_char = double(mi_char);
mi_char = dec2bin(mi_char);
mi_char = double(mi_char) - 48;
mi_char = mi_char';
mi_char = mi_char(:);

count_mi_64 = fix(length(mi_char) / 64);
for i_n3des = 1:count_mi_64
    miwen = mi_char((i_n3des - 1)*64 +1:i_n3des*64);
    miwen = miwen';
    min_des(i_n3des,:) = n3des(miwen, K_des);
end
min_des = min_des';
min_des = min_des(:);
min_des = min_des';
count_min_7 = fix(length(min_des) / 7);
for i_michar_minchar = 1:count_min_7
    min_char(i_michar_minchar, :) = min_des((i_michar_minchar-1)*7+1 : i_michar_minchar*7);
end
min_char = char(min_char + 48);
min_char = char(bin2dec(min_char));
min_char = min_char'
set(handles.edit2,'string',num2str(min_char))


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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global mi_char
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = ...
   uigetfile({'*.mat'},'选择文件');
str=[pathname filename];
mi_char=fopen(str);
mi_char=fread (mi_char);
% load mi_char
% mi_char=mi_char
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = ...
   uigetfile({'*.mat'},'选择文件');
str=[pathname filename];
codeRSA=fopen(str);
codeRSA=fread (codeRSA);
% load codeRSA
% codeRSA=codeRSA
