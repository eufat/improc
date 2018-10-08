function varargout = Segmentasi_Warna(varargin)
% SEGMENTASI_WARNA MATLAB code for Segmentasi_Warna.fig
%      SEGMENTASI_WARNA, by itself, creates a new SEGMENTASI_WARNA or raises the existing
%      singleton*.
%
%      H = SEGMENTASI_WARNA returns the handle to a new SEGMENTASI_WARNA or the handle to
%      the existing singleton*.
%
%      SEGMENTASI_WARNA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEGMENTASI_WARNA.M with the given input arguments.
%
%      SEGMENTASI_WARNA('Property','Value',...) creates a new SEGMENTASI_WARNA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Segmentasi_Warna_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Segmentasi_Warna_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Segmentasi_Warna

% Last Modified by GUIDE v2.5 22-Jun-2014 01:10:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Segmentasi_Warna_OpeningFcn, ...
    'gui_OutputFcn',  @Segmentasi_Warna_OutputFcn, ...
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


% --- Executes just before Segmentasi_Warna is made visible.
function Segmentasi_Warna_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Segmentasi_Warna (see VARARGIN)

% Choose default command line output for Segmentasi_Warna
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');

% UIWAIT makes Segmentasi_Warna wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Segmentasi_Warna_OutputFcn(hObject, eventdata, handles)
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
[namafile,namapath] = uigetfile({'*.jpg';'*.bmp';'*.png';'*.gif';'*.tif'});

if ~isequal(namafile,0)
    Img = imread(fullfile(namapath,namafile));
    axes(handles.axes1)
    imshow(Img)
else
    return
end

handles.Img = Img;
guidata(hObject,handles)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==0/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==21/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==43/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==85/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==128/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==170/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==191/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==213/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
[tinggi,lebar,~] = size(Img);
hsv = rgb2hsv(Img);

H = hsv(:,:,1);
S = hsv(:,:,2);
V = hsv(:,:,3);

for y=1: tinggi
    for x=1: lebar
        h = H(y,x);
        
        % Ubah warna
        if h < 11/255       % merah
            h = 0;
        elseif h < 32/255   % jingga
            h = 21/255;
        elseif h < 54/255   % kuning
            h = 43/255;
        elseif h < 116/255  % hijau
            h = 85/255;
        elseif h < 141/255  % cyan
            h = 128/255;
        elseif h < 185/255  % biru
            h = 170/255;
        elseif h < 202/255  % ungu
            h = 191/255;
        elseif h < 223/255  % magenta
            h = 213/255;
        elseif h < 244/255  % merah muda
            h = 234/255;
        else
            h = 0;          % merah
        end
        
        % Ubah komponen H
        H(y,x) = h;
        
        % Ubah komponen S
        if S(y,x) >= 200/255
            S(y,x) = 255/255;
        elseif S(y,x) <= 20/255
            S(y,x) = 0;
        else
            S(y,x) = 128/255;
        end
        
        % Ubah komponen V
        if V(y,x) >= 200/255
            V(y,x) = 255/255;
        elseif V(y,x) <= 20/255
            V(y,x) = 0;
        else
            V(y,x) = 128/255;
        end
    end
end

H_aksen = H==234/255;
H_aksen = logical(H_aksen);

R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

R(~H_aksen) = 255;
G(~H_aksen) = 255;
B(~H_aksen) = 255;

RGB = cat(3,R,G,B);

axes(handles.axes2)
imshow(RGB);

handles.H_aksen = H_aksen;
guidata(hObject,handles)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

H_aksen = handles.H_aksen;
slider_value1 = get(handles.slider1,'Value');
R(H_aksen) = R(H_aksen)+slider_value1;
if R(H_aksen)>255
    R(H_aksen) = 255;
elseif R(H_aksen)<0
    R(H_aksen) = 0;
end

slider_value2 = get(handles.slider2,'Value');
G(H_aksen) = G(H_aksen)+slider_value2;
if G(H_aksen)>255
    G(H_aksen) = 255;
elseif G(H_aksen)<0
    G(H_aksen) = 0;
end

slider_value3 = get(handles.slider3,'Value');
B(H_aksen) = B(H_aksen)+slider_value3;
if B(H_aksen)>255
    B(H_aksen) = 255;
elseif B(H_aksen)<0
    B(H_aksen) = 0;
end

RGB = cat(3,R,G,B);
axes(handles.axes1)
imshow(RGB)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

H_aksen = handles.H_aksen;
slider_value1 = get(handles.slider1,'Value');
R(H_aksen) = R(H_aksen)+slider_value1;
if R(H_aksen)>255
    R(H_aksen) = 255;
elseif R(H_aksen)<0
    R(H_aksen) = 0;
end

slider_value2 = get(handles.slider2,'Value');
G(H_aksen) = G(H_aksen)+slider_value2;
if G(H_aksen)>255
    G(H_aksen) = 255;
elseif G(H_aksen)<0
    G(H_aksen) = 0;
end

slider_value3 = get(handles.slider3,'Value');
B(H_aksen) = B(H_aksen)+slider_value3;
if B(H_aksen)>255
    B(H_aksen) = 255;
elseif B(H_aksen)<0
    B(H_aksen) = 0;
end

RGB = cat(3,R,G,B);
axes(handles.axes1)
imshow(RGB)


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

H_aksen = handles.H_aksen;
slider_value1 = get(handles.slider1,'Value');
R(H_aksen) = R(H_aksen)+slider_value1;
if R(H_aksen)>255
    R(H_aksen) = 255;
elseif R(H_aksen)<0
    R(H_aksen) = 0;
end

slider_value2 = get(handles.slider2,'Value');
G(H_aksen) = G(H_aksen)+slider_value2;
if G(H_aksen)>255
    G(H_aksen) = 255;
elseif G(H_aksen)<0
    G(H_aksen) = 0;
end

slider_value3 = get(handles.slider3,'Value');
B(H_aksen) = B(H_aksen)+slider_value3;
if B(H_aksen)>255
    B(H_aksen) = 255;
elseif B(H_aksen)<0
    B(H_aksen) = 0;
end

RGB = cat(3,R,G,B);
axes(handles.axes1)
imshow(RGB)


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
