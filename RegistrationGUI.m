% mannual registration of two images with user interface
% can apply translation, rotation, and scale
% the GUI can be openned by Registration.fig
% written by Yue Li
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = RegistrationGUI(varargin)
% REGISTRATION MATLAB code for Registration.fig
%      REGISTRATION, by itself, creates a new REGISTRATION or raises the existing
%      singleton*.
%
%      H = REGISTRATION returns the handle to a new REGISTRATION or the handle to
%      the existing singleton*.
%
%      REGISTRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTRATION.M with the given input arguments.
%
%      REGISTRATION('Property','Value',...) creates a new REGISTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Registration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Registration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Registration

% Last Modified by GUIDE v2.5 11-Jul-2015 21:53:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Registration_OpeningFcn, ...
                   'gui_OutputFcn',  @Registration_OutputFcn, ...
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

% --- Executes just before Registration is made visible.
function Registration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Registration (see VARARGIN)

% Choose default command line output for Registration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Registration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Registration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in TransXPos.
function TransXPos_Callback(hObject, eventdata, handles)
% hObject    handle to TransXPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

StepPixels = double(handles.Pixels); % read step
Tmp = handles.Fig2;  % set tmp as I2

AccumXPixel = double(handles.AccumXPixel);  % Read accumulated image shift in X;
AccumXPixel = StepPixels + AccumXPixel; % Calculated accumulated rotation X shift

AccumYPixel = double(handles.AccumYPixel);  % Read accumulated image shift in Y;
AccumDegree = double(handles.AccumDegree); % Read original accumulated rotation degrees

Tmp = circshift (Tmp,[round(AccumXPixel),round(AccumYPixel)]);    % Image CircShift according to accumY and acuum X shift

% Clear content out of the frame
if AccumXPixel>0            
    Tmp(1:round(AccumXPixel),:) = 0;
else
    Tmp(length(Tmp)+round(AccumXPixel):end,:) = 0; 
end
if AccumYPixel>0            
    Tmp(:,1:round(AccumYPixel)) = 0;
else
    Tmp(:,length(Tmp)-round(AccumYPixel):end) = 0; 
end

Tmp = imrotate(Tmp,AccumDegree,'crop'); % Rotate Tmp according to accumDegree

axes(handles.axes1);    % Displace overlay image
I1 = handles.Fig1;
imshowpair(I1,Tmp);

handles.AccumXPixel = AccumXPixel;  % Update accumulated rotation degrees
guidata(hObject,handles);

% --- Executes on button press in TranXNeg.
function TranXNeg_Callback(hObject, eventdata, handles)
% hObject    handle to TranXNeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

StepPixels = double(handles.Pixels); % read step
Tmp = handles.Fig2;  % set tmp as I2

AccumXPixel = double(handles.AccumXPixel);  % Read accumulated image shift in X;
AccumXPixel = -StepPixels + AccumXPixel; % Calculated accumulated rotation X shift

AccumYPixel = double(handles.AccumYPixel);  % Read accumulated image shift in Y;
AccumDegree = double(handles.AccumDegree); % Read original accumulated rotation degrees

Tmp = circshift (Tmp,[round(AccumXPixel),round(AccumYPixel)]);    % Image CircShift according to accumY and acuum X shift

% Clear content out of the frame
if AccumXPixel>0            
    Tmp(1:round(AccumXPixel),:) = 0;
else
    Tmp(length(Tmp)+round(AccumXPixel):end,:) = 0; 
end
if AccumYPixel>0            
    Tmp(:,1:round(AccumYPixel)) = 0;
else
    Tmp(:,length(Tmp)-round(AccumYPixel):end) = 0; 
end

Tmp = imrotate(Tmp,AccumDegree,'crop'); % Rotate Tmp according to accumDegree

axes(handles.axes1);    % Displace overlay image
I1 = handles.Fig1;
imshowpair(I1,Tmp);

handles.AccumXPixel = AccumXPixel;  % Update accumulated rotation degrees
guidata(hObject,handles);


% --- Executes on button press in CCW.
function CCW_Callback(hObject, eventdata, handles)
% hObject    handle to CCW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
StepDegrees = double(handles.Degrees); % read step
Tmp = handles.Fig2;  % set tmp as I2

AccumXPixel = double(handles.AccumXPixel);  % Read accumulated image shift in X;
AccumYPixel = double(handles.AccumYPixel);  % Read accumulated image shift in Y;

AccumDegree = double(handles.AccumDegree); % Read original accumulated rotation degrees
AccumDegree = StepDegrees + AccumDegree; % Calculated accumulated rotation degrees

Tmp = circshift (Tmp,[round(AccumXPixel),round(AccumYPixel)]);    % Image CircShift according to accumY and acuum X shift

% Clear content out of the frame
if AccumXPixel>0            
    Tmp(:,1:round(AccumXPixel)) = 0;
else
    Tmp(:,length(Tmp)+round(AccumXPixel):end) = 0; 
end
if AccumYPixel>0            
    Tmp(1:round(AccumYPixel),:) = 0;
else
    Tmp(length(Tmp)-round(AccumYPixel):end,:) = 0; 
end

Tmp = imrotate(Tmp,AccumDegree,'crop'); % Rotate Tmp according to accumDegree

axes(handles.axes1);    % Displace overlay image
I1 = handles.Fig1;
imshowpair(I1,Tmp);

handles.AccumDegree = AccumDegree;  % Update accumulated rotation degrees
guidata(hObject,handles);


% --- Executes on button press in CW.
function CW_Callback(hObject, eventdata, handles)
% hObject    handle to CW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

StepDegrees = double(handles.Degrees); % read step
Tmp = handles.Fig2;  % set tmp as I2

AccumXPixel = double(handles.AccumXPixel);  % Read accumulated image shift in X;
AccumYPixel = double(handles.AccumYPixel);  % Read accumulated image shift in Y;

AccumDegree = double(handles.AccumDegree); % Read original accumulated rotation degrees
AccumDegree = -StepDegrees + AccumDegree; % Calculated accumulated rotation degrees

Tmp = circshift (Tmp,[round(AccumXPixel),round(AccumYPixel)]);    % Image CircShift according to accumY and acuum X shift

% Clear content out of the frame
if AccumXPixel>0            
    Tmp(1:round(AccumXPixel),:) = 0;
else
    Tmp(length(Tmp)+round(AccumXPixel):end,:) = 0; 
end
if AccumYPixel>0            
    Tmp(:,1:round(AccumYPixel)) = 0;
else
    Tmp(:,length(Tmp)-round(AccumYPixel):end) = 0; 
end

Tmp = imrotate(Tmp,AccumDegree,'crop'); % Rotate Tmp according to accumDegree

axes(handles.axes1);    % Displace overlay image
I1 = handles.Fig1;
imshowpair(I1,Tmp);

handles.AccumDegree = AccumDegree;  % Update accumulated rotation degrees
guidata(hObject,handles);

% --- Executes on button press in TransYNeg.
function TransYNeg_Callback(hObject, eventdata, handles)
% hObject    handle to TransYNeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

StepPixels = double(handles.Pixels); % read step
Tmp = handles.Fig2;  % set tmp as I2

AccumXPixel = double(handles.AccumXPixel);  % Read accumulated image shift in X;

AccumYPixel = double(handles.AccumYPixel);  % Read accumulated image shift in Y;
AccumYPixel = -StepPixels + AccumYPixel; % Calculated accumulated rotation X shift

AccumDegree = double(handles.AccumDegree); % Read original accumulated rotation degrees

Tmp = circshift (Tmp,[round(AccumXPixel),round(AccumYPixel)]);    % Image CircShift according to accumY and acuum X shift

% Clear content out of the frame
if AccumXPixel>0            
    Tmp(1:round(AccumXPixel),:) = 0;
else
    Tmp(length(Tmp)+round(AccumXPixel):end,:) = 0; 
end
if AccumYPixel>0            
    Tmp(:,1:round(AccumYPixel)) = 0;
else
    Tmp(:,length(Tmp)-round(AccumYPixel):end) = 0; 
end

Tmp = imrotate(Tmp,AccumDegree,'crop'); % Rotate Tmp according to accumDegree

axes(handles.axes1);    % Displace overlay image
I1 = handles.Fig1;
imshowpair(I1,Tmp);

handles.AccumYPixel = AccumYPixel;  % Update accumulated rotation degrees
guidata(hObject,handles);

% --- Executes on button press in TransYPos.
function TransYPos_Callback(hObject, eventdata, handles)
% hObject    handle to TransYPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

StepPixels = double(handles.Pixels); % read step
Tmp = handles.Fig2;  % set tmp as I2

AccumXPixel = double(handles.AccumXPixel);  % Read accumulated image shift in X;

AccumYPixel = double(handles.AccumYPixel);  % Read accumulated image shift in Y;
AccumYPixel = StepPixels + AccumYPixel; % Calculated accumulated rotation X shift

AccumDegree = double(handles.AccumDegree); % Read original accumulated rotation degrees

Tmp = circshift (Tmp,[round(AccumXPixel),round(AccumYPixel)]);    % Image CircShift according to accumY and acuum X shift

% Clear content out of the frame
if AccumXPixel>0            
    Tmp(1:round(AccumXPixel),:) = 0;
else
    Tmp(length(Tmp)+round(AccumXPixel):end,:) = 0; 
end
if AccumYPixel>0            
    Tmp(:,1:round(AccumYPixel)) = 0;
else
    Tmp(:,length(Tmp)-round(AccumYPixel):end) = 0; 
end

Tmp = imrotate(Tmp,AccumDegree,'crop'); % Rotate Tmp according to accumDegree

axes(handles.axes1);    % Displace overlay image
I1 = handles.Fig1;
imshowpair(I1,Tmp);

handles.AccumYPixel = AccumYPixel;  % Update accumulated rotation degrees
guidata(hObject,handles);

% --- Executes on button press in SaveFile.
function SaveFile_Callback(hObject, eventdata, handles)
% hObject    handle to SaveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
field1 = 'RotationDegree'; value1 = {double(handles.AccumDegree)};
field2 = 'XShift'; value2 = {double(handles.AccumXPixel)};
field3 = 'YShift'; value3 = {double(handles.AccumYPixel)};

s = struct(field1,value1,field2,value2,field3,value3);  %Save the transformation in the open dialogue
uisave('s','Transformation');

% --- Executes on button press in ResetParameters.
function ResetParameters_Callback(hObject, eventdata, handles)
% hObject    handle to ResetParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.AccumDegree = 0;    % reset accumulated rotation degrees
handles.AccumXPixel = 0;    % reset accumulated image X shift
handles.AccumYPixel = 0;    % reset accumulated image Y shift

axes(handles.axes1);    % dispplay overlay image
I1 = handles.Fig1;
I2 = handles.Fig2;
imshowpair(I1,I2);

hold on   % Display strecthing axis
x = 1:2:length(I1);
y = 0.*x+0.5*length(I1);
plot(x,y,'LineWidth',0.2,'LineStyle','--','Color',[1 0 0]);
plot(x,y,'LineWidth',0.2,'LineStyle','--','Color',[0 0 1]);

guidata(hObject,handles);   % update handles

% --- Executes on button press in Fig1.
function Fig1_Callback(hObject, eventdata, handles)
% hObject    handle to Fig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1 = uigetfile;
handles.Fig1 = imread(I1);
guidata(hObject, handles);

% --- Executes on button press in Fig2.
function Fig2_Callback(hObject, eventdata, handles)
% hObject    handle to Fig2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I2 = uigetfile;
handles.Fig2 = imread(I2);
guidata(hObject,handles);

% --- Executes on button press in Display.
function Display_Callback(hObject, eventdata, handles)
% hObject    handle to Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Display overlay image of I1 and I2
axes(handles.axes1);
I1 = handles.Fig1;
I2 = handles.Fig2;
imshowpair(I1,I2);

hold on   % Display strecthing axis
x = 1:2:length(I1);
y = 0.*x+0.5*length(I1);
plot(x,y,'LineWidth',0.2,'LineStyle','--','Color',[1 0 0]);
plot(x,y,'LineWidth',0.2,'LineStyle','--','Color',[0 0 1]);

handles.AccumDegree=0;    % initial accumulated rotation degrees
handles.AccumXPixel=0;    % initial accumulated image X shift
handles.AccumYPixel=0;    % initial accumulated image Y shift


guidata(hObject,handles);   % Update handles.

% --- Executes during object creation, after setting all properties.
function Percentage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Pixels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pixels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Degrees_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function CCW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CCW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function Percentage_Callback(hObject, eventdata, handles)
% hObject    handle to Percentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MaxPercentage = 0.5;
MinPercentage = 0;
handles.Percentage = (MaxPercentage-MinPercentage)*get(hObject,'Value');
guidata(hObject,handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes on slider movement.
function Pixels_Callback(hObject, eventdata, handles)
% hObject    handle to Pixels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

MaxPixel = 10;
MinPixel = 0;
handles.Pixels = (MaxPixel-MinPixel)*get(hObject,'Value');
guidata(hObject,handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes on slider movement.
function Degrees_Callback(hObject, eventdata, handles)
% hObject    handle to Degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MaxDegree = 10;
MinDegree = 0;
handles.Degrees = (MaxDegree-MinDegree)*get(hObject,'Value');
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes on slider movement.
function StretchAxis_Callback(hObject, eventdata, handles)
% hObject    handle to StretchAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MaxAxis = 90;
MinAxis = 0;
handles.Axis = (MaxAxis-MinAxis)*get(hObject,'Value');  % Get axis value
Axis = handles.Axis;
guidata(hObject,handles);

Tmp = handles.Fig2;  % set tmp as I2

AccumXPixel = double(handles.AccumXPixel);  % Read accumulated image shift in X;
AccumYPixel = double(handles.AccumYPixel);  % Read accumulated image shift in Y;
AccumDegree = double(handles.AccumDegree); % Read original accumulated rotation degrees

Tmp = circshift (Tmp,[round(AccumXPixel),round(AccumYPixel)]);    % Image CircShift according to accumY and acuum X shift

% Clear content out of the frame
if AccumXPixel>0            
    Tmp(1:round(AccumXPixel),:) = 0;
else
    Tmp(length(Tmp)+round(AccumXPixel):end,:) = 0; 
end
if AccumYPixel>0            
    Tmp(:,1:round(AccumYPixel)) = 0;
else
    Tmp(:,length(Tmp)-round(AccumYPixel):end) = 0; 
end

Tmp = imrotate(Tmp,AccumDegree,'crop'); % Rotate Tmp according to accumDegree

axes(handles.axes1);    % Display overlay image
I1 = handles.Fig1;
imshowpair(I1,Tmp);

hold on       % Display two axis
x = 1:2:length(I1);
y = 0.*x+0.5*length(I1);
plot(x,y,'LineWidth',0.2,'LineStyle','--','Color',[1 0 0]);
z = -1*tand(double(Axis)).*(x-0.5*length(I1))+0.5*length(I1);
plot(x,z,'LineWidth',0.2,'LineStyle','--','Color',[0 0 1]);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function StretchAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StretchAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in StretchNeg.
function StretchNeg_Callback(hObject, eventdata, handles)
% hObject    handle to StretchNeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in StretchPos.
function StretchPos_Callback(hObject, eventdata, handles)
% hObject    handle to StretchPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function Display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
