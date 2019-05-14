%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This project is created to do face recognition for     %%%
%%% a set of subjects, each of them has 10 pictures with   %%%
%%% different emotions.                                    %%%
%%% Team #1: Ahmad M. Sebaq, Hassan Esam, and Hana Karam.  %%%
%%% References:                                            %%%
%%% 1. https://www.mathworks.com/matlabcentral/fileexchange/16760-face-recognition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = face_recognition_gui(varargin)
% FACE_RECOGNITION_GUI MATLAB code for face_recognition_gui.fig
%      FACE_RECOGNITION_GUI, by itself, creates a new FACE_RECOGNITION_GUI or raises the existing
%      singleton*.
%
%      H = FACE_RECOGNITION_GUI returns the handle to a new FACE_RECOGNITION_GUI or the handle to
%      the existing singleton*.
%
%      FACE_RECOGNITION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACE_RECOGNITION_GUI.M with the given input arguments.
%
%      FACE_RECOGNITION_GUI('Property','Value',...) creates a new FACE_RECOGNITION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before face_recognition_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to face_recognition_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help face_recognition_gui

% Last Modified by GUIDE v2.5 07-May-2018 02:04:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @face_recognition_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @face_recognition_gui_OutputFcn, ...
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


% --- Executes just before face_recognition_gui is made visible.
function face_recognition_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to face_recognition_gui (see VARARGIN)

% Choose default command line output for face_recognition_gui
handles.output = hObject;

set(handles.text2, 'visible', 'off');
set(handles.text3, 'visible', 'off');
set(handles.axes1, 'box', 'off', 'XTickLabel', [], 'XTick', [],...
    'YTickLabel', [], 'YTick', []);
set(handles.axes2, 'box', 'off', 'XTickLabel', [], 'XTick', [],...
    'YTickLabel', [], 'YTick', []);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes face_recognition_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = face_recognition_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pickButton.
function pickButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global index;

% Read and show image in MATLAB
[name, path] = uigetfile('*.pgm');
if ~isequal(name, 0) || ~isequal(path, 0)
    image = imread(fullfile(path, name));
    imshow(image, 'Parent', handles.axes1);
    set(handles.axes1, 'box', 'off', 'XTickLabel', [], 'XTick', [],...
    'YTickLabel', [], 'YTick', []);
    index = ((str2double(path(end-2: end-1)) - 1) * 10) + str2double(name(1:2));
    if isnan(index)
        index = ((str2double(path(end-1)) - 1) * 10) + str2double(name(1:2));
    end
    text = sprintf('Looking for face - index(%d)',index);
    set(handles.text2, 'String', text);
    set(handles.text2, 'visible', 'on');

else
    errordlg('User does not choose an image file','Type Error');
end



% --- Executes on button press in trainButton.
function trainButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global index;
global test;
global train;
global imgMean;
global V;
global feature;

% Train the algorithm through the 399 left images
greenBar = waitbar(0,'Training...');
[test, train, imgMean, V, feature] = FaceRecognition(index);
waitbar(1);
close(greenBar)

    
% --- Executes on button press in recognizeButton.
function recognizeButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global test;
global train;
global imgMean;
global V;
global feature;
% Classify and recognize the face then return the best match from the database
image = Classification(test, train, imgMean, V, feature);
imshow(image, 'Parent', handles.axes2);
set(handles.axes2, 'box', 'off', 'XTickLabel', [], 'XTick', [],...
    'YTickLabel', [], 'YTick', []);
set(handles.text3, 'String', 'Found.');
set(handles.text3, 'visible', 'on');
