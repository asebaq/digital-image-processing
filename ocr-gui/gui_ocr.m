%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This project is created to do optical character        %%%
%%% rcognition(OCR) for letter A, by identifing the letter %%%
%%% with a red square around it.                           %%%
%%% Team #1: Ahmad M. Sebaq, Hassan Esam, and Hana Karam.  %%%
%%% References:
%%% 1. https://www.mathworks.com/matlabcentral/fileexchange/31322-
%%% optical-character-recognition-lower-case-and-space-included-
%%%
%%% 2. https://www.mathworks.com/matlabcentral/answers/24467-identifying-
%%% objects-in-a-picture-containing-several-objects
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = gui_ocr(varargin)
% GUI_OCR MATLAB code for gui_ocr.fig
%      GUI_OCR, by itself, creates a new GUI_OCR or raises the existing
%      singleton*.
%
%      H = GUI_OCR returns the handle to a new GUI_OCR or the handle to
%      the existing singleton*.
%
%      GUI_OCR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_OCR.M with the given input arguments.
%
%      GUI_OCR('Property','Value',...) creates a new GUI_OCR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_ocr_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_ocr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_ocr

% Last Modified by GUIDE v2.5 23-Mar-2018 18:12:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_ocr_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_ocr_OutputFcn, ...
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


% --- Executes just before gui_ocr is made visible.
function gui_ocr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_ocr (see VARARGIN)

global image;
image = 0;

set(handles.text4, 'visible', 'off');

% Choose default command line output for gui_ocr
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_ocr wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_ocr_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openButton.
function openButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global image;

% Read and show image in MATLAB
[name, path] = uigetfile({'*.jpg', '*.png'});
if ~isequal(name, 0) || ~isequal(path, 0)
    image = imread(fullfile(path, name));
    imshow(image, 'Parent', handles.axes1);
else
    errordlg('User does not choose an image file','Type Error');
end


% --- Executes on button press in ocrButton.
function ocrButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global image;

% optical character recognition
if ~isequal(image, 0)
    [letter, found, outputImage] = ocr_a(image);
    if found
        text = 'Found.';
        set(handles.text4, 'String',text);
        set(handles.text4, 'visible', 'on');
    else
        set(handles.text4, 'visible', 'on');
    end
    imshow(outputImage, 'Parent', handles.axes1);
else
    errordlg('User does not choose an image file','Type Error');
end
