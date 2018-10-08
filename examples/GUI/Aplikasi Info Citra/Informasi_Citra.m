function varargout = Informasi_Citra(varargin)
% INFORMASI_CITRA MATLAB code for Informasi_Citra.fig
%      INFORMASI_CITRA, by itself, creates a new INFORMASI_CITRA or raises the existing
%      singleton*.
%
%      H = INFORMASI_CITRA returns the handle to a new INFORMASI_CITRA or the handle to
%      the existing singleton*.
%
%      INFORMASI_CITRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INFORMASI_CITRA.M with the given input arguments.
%
%      INFORMASI_CITRA('Property','Value',...) creates a new INFORMASI_CITRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Informasi_Citra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Informasi_Citra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Informasi_Citra

% Last Modified by GUIDE v2.5 07-Apr-2016 00:44:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Informasi_Citra_OpeningFcn, ...
                   'gui_OutputFcn',  @Informasi_Citra_OutputFcn, ...
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


% --- Executes just before Informasi_Citra is made visible.
function Informasi_Citra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Informasi_Citra (see VARARGIN)

% Choose default command line output for Informasi_Citra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');

% UIWAIT makes Informasi_Citra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Informasi_Citra_OutputFcn(hObject, eventdata, handles) 
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
[nama_file,path_file] = uigetfile({'*.*'});
if ~isequal(nama_file,0)
    I = imread(fullfile(path_file,nama_file));
    axes(handles.axes1)
    imshow(I)
    
    info = imfinfo(fullfile(path_file,nama_file));

data = get(handles.uitable1,'Data');
data{1,1} = nama_file;
data{2,1} = info.FileSize;
data{3,1} = info.Width;
data{4,1} = info.Height;
data{5,1} = info.BitDepth;
data{6,1} = info.ColorType;

set(handles.uitable1,'Data',data)
else
    return
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.uitable1,'Data',[])