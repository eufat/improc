function varargout = Konversi_HU(varargin)
% KONVERSI_HU MATLAB code for Konversi_HU.fig
%      KONVERSI_HU, by itself, creates a new KONVERSI_HU or raises the existing
%      singleton*.
%
%      H = KONVERSI_HU returns the handle to a new KONVERSI_HU or the handle to
%      the existing singleton*.
%
%      KONVERSI_HU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KONVERSI_HU.M with the given input arguments.
%
%      KONVERSI_HU('Property','Value',...) creates a new KONVERSI_HU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Konversi_HU_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Konversi_HU_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Konversi_HU

% Last Modified by GUIDE v2.5 22-Mar-2015 16:06:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Konversi_HU_OpeningFcn, ...
                   'gui_OutputFcn',  @Konversi_HU_OutputFcn, ...
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


% --- Executes just before Konversi_HU is made visible.
function Konversi_HU_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Konversi_HU (see VARARGIN)

% Choose default command line output for Konversi_HU
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');

% UIWAIT makes Konversi_HU wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Konversi_HU_OutputFcn(hObject, eventdata, handles) 
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
% global filename pathname Img
[filename,pathname] = uigetfile({'*.dcm';'*.*'},'Buka File Dicom');

if ~isequal(filename,0)
    Img = dicomread(fullfile(pathname,filename));
    axes(handles.axes1)
    imshow(Img,[])
else
    return
end

Info = dicominfo(fullfile(pathname,filename));
handles.Info = Info;
handles.Img = Img;
guidata(hObject, handles)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
Info = handles.Info;
Intercept = Info.RescaleIntercept;
Slope = Info.RescaleSlope;
[m,n] = size(Img);
MatriksBaru = int16(zeros(m,n));
for i = 1:m
    for j = 1:n
        MatriksBaru(i,j) = int16(Img(i,j))*Slope+Intercept;
    end
end

axes(handles.axes2)
imshow((MatriksBaru),[])

handles.MatriksBaru = MatriksBaru;
guidata(hObject, handles)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 150;
WindowLevel= 35;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 70;
WindowLevel= 35;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 4095;
WindowLevel= 600;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 2000;
WindowLevel= 800;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 1600;
WindowLevel= -600;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 350;
WindowLevel= 60;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 200;
WindowLevel= 100;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton9,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 220;
WindowLevel= 25;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton10,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 300;
WindowLevel= 60;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
set(handles.radiobutton8,'Value',0)
set(handles.radiobutton9,'Value',0)

Img = handles.Img;
MatriksBaru = handles.MatriksBaru;

WindowWidth= 270;
WindowLevel= -35;
BatasBawah=WindowLevel-(WindowWidth/2);
BatasAtas=WindowLevel+(WindowWidth/2);
Bawah=double(BatasAtas-BatasBawah);
[m,n] = size(Img);
B=zeros(m,n);
for i=1:m
    for j=1:n
        if (MatriksBaru(i,j)< BatasBawah)
            B(i,j)=BatasBawah;
        elseif (MatriksBaru(i,j) > BatasAtas)
            B(i,j)=BatasAtas;
        else
            x=MatriksBaru(i,j);
            Atas=double(x-BatasBawah);
            Perbandingan=Atas/Bawah;
            B(i,j)=(Perbandingan*WindowWidth)+(BatasBawah);
        end
    end
end
axes(handles.axes2);
imshow(B,'DisplayRange',[]);


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
