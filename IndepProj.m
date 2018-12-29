function varargout = IndepProj(varargin)
% INDEPPROJ MATLAB code for IndepProj.fig
%      INDEPPROJ, by itself, creates a new INDEPPROJ or raises the existing
%      singleton*.
%
%      H = INDEPPROJ returns the handle to a new INDEPPROJ or the handle to
%      the existing singleton*.
%
%      INDEPPROJ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INDEPPROJ.M with the given input arguments.
%
%      INDEPPROJ('Property','Value',...) creates a new INDEPPROJ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IndepProj_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IndepProj_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IndepProj

% Last Modified by GUIDE v2.5 08-Dec-2018 14:03:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IndepProj_OpeningFcn, ...
                   'gui_OutputFcn',  @IndepProj_OutputFcn, ...
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


% --- Executes just before IndepProj is made visible.
function IndepProj_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IndepProj (see VARARGIN)

% Choose default command line output for IndepProj
handles.output = hObject;

handles.xplayer = 0;
handles.yplayer = 0;

handles.xb = 0;
handles.yb= 0;

handles.x = 0:1:100;
handles.y = -20;
handles.y1 = 20;

plot(handles.x,handles.y*ones(size(handles.x)),'k')
set(gca,'FontSize',5)
xticks([0:1:100])
yticks([-50:1:50])
grid on
hold on
xlim([0 100])
ylim([-50 50])
plot(handles.x,handles.y1*ones(size(handles.x)),'k')
hold on

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IndepProj wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IndepProj_OutputFcn(hObject, eventdata, handles) 
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
obstacleavoidance_Callback(hObject, eventdata, handles)



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.xplayer = 0;
handles.yplayer = handles.slider1.Value;

xp = handles.xplayer;
yp = handles.yplayer;

cla
handles.x = 0:1:100;
handles.y = -20;
handles.y1 = 20;

plot(handles.x,handles.y*ones(size(handles.x)),'k')
hold on
xlim([0 100])
ylim([-50 50])
plot(handles.x,handles.y1*ones(size(handles.x)),'k')
hold on
grid on

plot(xp,yp,'.','MarkerSize',20)
hold on
if handles.xb ~= 0
    plot(handles.xb,handles.yb,'.','MarkerSize',9)
end
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
handles.x = 0:1:100;
handles.y = -20;
handles.y1 = 20;

plot(handles.x,handles.y*ones(size(handles.x)),'k')
hold on
xlim([0 100])
ylim([-50 50])
plot(handles.x,handles.y1*ones(size(handles.x)),'k')
hold on
grid on

% rng(1)
handles.xb = randi([3,99],1,1000);
handles.yb = randi([-20,20],1,1000);

x = handles.xb;
y = handles.yb;

plot(x,y,'.','MarkerSize',9)
hold on
 
xp = 0;
yp = handles.slider1.Value;
plot(xp,yp,'.','MarkerSize',20)

guidata(hObject, handles);

function obstacleavoidance_Callback(hObject, eventdata, handles)
h = animatedline('Color','k','LineWidth',.1);

x = linspace(0,100,300);
y = (x*0)+handles.yplayer;
xblock = handles.xb;
yblock = handles.yb;

sorted = (sortrows([xblock',yblock'], 1))';
xb = sorted(1,:);
yb = sorted(2,:);

ylowlimit = -19;
yupperlimit = 19;

%  figure(9)
%  cla
%  plot(xblock, yblock,'o')
%  hold on


for k = 1:2
    addpoints(h,x(k),y(k));
    drawnow
end

for k = 2:length(x)
    y(k) = y(k-1);
    for i = 1:length(xb)
        val = sqrt((y(k)-yb(i))^2+ (x(k)-xb(i))^2);
        if x(k) - xb(i) < 0 && y(k) - yb(i) < 1
            if val <= 1.25 && y(k) < yb(i)
               y(k) = y(k) - .25;
            elseif val <= 1.25 && y(k) > yb(i) 
                y(k) = y(k) + .35;
            elseif y(k) <= ylowlimit
                y(k) = y(k) + .35;
            elseif y(k) >= yupperlimit
                y(k) = y(k) - .25;
            end
        end
    end
%     figure(9)
%     plot(x(1:k),y(1:k),'ro')
%     axis([x(k)-3 x(k)+3 y(k)-3 y(k)+3 ])
%     pause(0.1)
    
    addpoints(h,x(k),y(k));
    drawnow
end
guidata(hObject,handles);
