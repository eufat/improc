function varargout = kompresi_JPEG(varargin)
% KOMPRESI_JPEG MATLAB code for kompresi_JPEG.fig
%      KOMPRESI_JPEG, by itself, creates a new KOMPRESI_JPEG or raises the existing
%      singleton*.
%
%      H = KOMPRESI_JPEG returns the handle to a new KOMPRESI_JPEG or the handle to
%      the existing singleton*.
%
%      KOMPRESI_JPEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KOMPRESI_JPEG.M with the given input arguments.
%
%      KOMPRESI_JPEG('Property','Value',...) creates a new KOMPRESI_JPEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kompresi_JPEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kompresi_JPEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kompresi_JPEG

% Last Modified by GUIDE v2.5 19-Jul-2013 12:33:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kompresi_JPEG_OpeningFcn, ...
                   'gui_OutputFcn',  @kompresi_JPEG_OutputFcn, ...
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


% --- Executes just before kompresi_JPEG is made visible.
function kompresi_JPEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kompresi_JPEG (see VARARGIN)

% Choose default command line output for kompresi_JPEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');
% UIWAIT makes kompresi_JPEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kompresi_JPEG_OutputFcn(hObject, eventdata, handles) 
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
[nama_file1, nama_path1] = uigetfile( ...
    {'*.bmp;*.jpg;*.tif;*.png','File Citra (*.bmp,*.jpg,*.tif,*.png)';
    '*.bmp','Windows Bitmap (*.bmp)';
    '*.jpg','JPEG Bitmaps (*.jpg)';
    '*.tif','Tiff Bitmap (*.tif)';
    '*.png','Portable Network Graphics (*.png)';
    '*.*','Semua File(*.*)'},...
    'Buka File Citra Host/Asli');
if ~isequal(nama_file1,0)
    handles.data1 = imread(fullfile(nama_path1,nama_file1));
    guidata(hObject,handles);
    handles.current_data1 = handles.data1;
    axes(handles.axes1);
    imshow(handles.current_data1);
else
    return
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nama_file_simpan,path_simpan] = uiputfile(...
    {'*.jpg','citra jpg (*.jpg)';
    '*.*','Semua file(*.*)'},...
    'Menyimpan File Citra Hasil Kompresi JPEG');
if ~isequal(nama_file_simpan,0)
    imwrite(handles.data1,fullfile(path_simpan,nama_file_simpan),...
        'quality',handles.quality);
    citra_kompres = imread(fullfile(path_simpan,nama_file_simpan));
    axes(handles.axes2);
    imshow(citra_kompres);
else
    return
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
val = get(hObject,'Value');
switch val
    case 1
        quality = 25;
    case 2
        quality = 50;
    case 3
        quality = 75;
    case 4
        quality = 100;
end
handles.quality = quality;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
