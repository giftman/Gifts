function varargout = first1(varargin)
% FIRST1 M-file for first1.fig
%      FIRST1, by itself, creates a new FIRST1 or raises the existing
%      singleton*.
%
%      H = FIRST1 returns the handle to a new FIRST1 or the handle to
%      the existing singleton*.
%
%      FIRST1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRST1.M with the given input arguments.
%
%      FIRST1('Property','Value',...) creates a new FIRST1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before first1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to first1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help first1

% Last Modified by GUIDE v2.5 30-Sep-2010 15:52:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @first1_OpeningFcn, ...
                   'gui_OutputFcn',  @first1_OutputFcn, ...
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


% --- Executes just before first1 is made visible.
function first1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to first1 (see VARARGIN)

% Choose default command line output for first1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes first1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = first1_OutputFcn(hObject, eventdata, handles) 
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


