%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This project is created to do some image manipulation  %%%
%%% with the basic image processing functions in MATLAB.   %%%
%%% Filters like:                                          %%%
%%% median, average, Sobel, Robert, Gaussian, Laplace.     %%%
%%% Transformations like:                                  %%%
%%% log, power, negative, Piecewise-Linear.                %%%
%%% Line detection like:                                   %%%
%%% 1st, 2ndderivative, canny, houghtransform.             %%%
%%% And Histogram equalization.                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = image_processing_gui(varargin)
% IMAGE_PROCESSING_GUI MATLAB code for image_processing_gui.fig
%      IMAGE_PROCESSING_GUI, by itself, creates a new IMAGE_PROCESSING_GUI or raises the existing
%      singleton*.
%
%      H = IMAGE_PROCESSING_GUI returns the handle to a new IMAGE_PROCESSING_GUI or the handle to
%      the existing singleton*.
%
%      IMAGE_PROCESSING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_PROCESSING_GUI.M with the given input arguments.
%
%      IMAGE_PROCESSING_GUI('Property','Value',...) creates a new IMAGE_PROCESSING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image_processing_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image_processing_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image_processing_gui

% Last Modified by GUIDE v2.5 20-Feb-2018 17:11:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image_processing_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @image_processing_gui_OutputFcn, ...
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

% --- Executes just before image_processing_gui is made visible.
function image_processing_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image_processing_gui (see VARARGIN)

global inputImage;
global outputImage;
global n;

set(handles.rgb2grayButton, 'visible','off');
set(handles.applyButton, 'visible','off');
set(handles.saveButton, 'visible','off');
set(handles.popupmenu, 'visible', 'off');
set(handles.text3, 'visible','off');
set(handles.text4, 'visible','off');

% Choose default command line output for image_processing_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image_processing_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = image_processing_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in openButton.
function openButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global inputImage;
global outputImage;

% Get the image file
[name, path] = uigetfile({'*.jpg', '*.png'});
if ~isequal(name, 0) || ~isequal(path, 0)
    % Clean things up and pre-allocate
    cla(handles.axes2,'reset');
    cla(handles.axes4,'reset');
    outputImage = 0;
    % Read and show image in MATLAB
    fullname = fullfile(path, name);
    inputImage = imread(fullname);
    imshow(inputImage, 'Parent', handles.axes1);
    axes(handles.axes3), imhist(inputImage);
    % Show the control options in GUI
    set(handles.rgb2grayButton, 'visible','on', 'enable', 'off');
    set(handles.applyButton, 'visible','on');
    set(handles.saveButton, 'visible','on');
    set(handles.popupmenu, 'visible', 'on');
    set(handles.text4, 'visible','on');
    set(handles.text3, 'visible','off');    
    % Check for RGB images
    if size(inputImage,3) == 3
        set(handles.rgb2grayButton, 'enable','on');
    end
    
else
    disp("User does not choose an image file");
end

% --- Executes on button press in applyButton.
function applyButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global outputImage;
if ~isequal(outputImage,0)
    % Show the output image(after processing) and its histogram
    imshow(outputImage, 'Parent', handles.axes2);
    axes(handles.axes4), imhist(outputImage);
else
    errordlg('There is no specified effect to show.','Error');
end

% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% Invoke global variables
global outputImage;
global inputImage;
global n;

% Get pop-up menu input choice
str = get(hObject, 'String');
val = get(hObject, 'Value');

switch str{val}
    case ''
        outputImage = inputImage;
    % Apply Median filter
    case 'Median'
        if size(inputImage,3) == 3
            errordlg('Image have to be in Gray-Scale','Image Type Error');
        else
            % Get filter size from user
            input = inputdlg('Filter size:');
            n = str2double(input{:});
            if ~isnan(n)
                outputImage = medfilt2(inputImage, [n n]);
            else
                errordlg('Enter a numeric value','Type Error');
            end
        end
        
    % Apply Average filter
    case 'Average'
        % Get filter size from user
        input = inputdlg('Filter size:');
        n = str2double(input{:});
        if ~isnan(n)
            % Create filter
            average_filter = fspecial('average',[n n]);
            outputImage = imfilter(inputImage, average_filter);
        else
            errordlg('Enter a numeric value','Type Error');
        end
        
    % Apply Sobel filter    
    case 'Sobel'
        % Check for RGB images
        if size(inputImage,3) == 3
            errordlg('Image have to be in Gray-Scale','Image Type Error');
        else
            outputImage = edge(inputImage,'Sobel');
        end
        
    % Apply Robert filter    
    case 'Robert'
        if size(inputImage,3) == 3
            errordlg('Image have to be in Gray-Scale','Image Type Error');
        else
            outputImage = edge(inputImage,'Roberts');
        end
        
    % Apply Gaussian filter    
    case 'Gaussian'
        % Get sigma fro the user
        input = inputdlg('Sigma - 0.5 for default - :');
        n = str2double(input{:});
        if ~isnan(n)        
            outputImage = imgaussfilt(inputImage,n);
        else
            errordlg('Enter a numeric value','Type Error');
        end
        
    % Apply Laplacian filter    
    case 'Laplacian'
        % Create filter
        laplace_filter = fspecial('laplacian');
        outputImage = imfilter(inputImage, laplace_filter);
        
    % Apply Log Transformation    
    case 'Log'
        outputImage = im2uint8(mat2gray(log(1 + double(inputImage))));
        
    % Apply Power(Gamma Transformation)    
    case 'Power'
        % Get gamma value from user
        input = inputdlg('Gamma:');
        n = str2double(input{:});
        if ~isnan(n) 
            outputImage = imadjust(inputImage, [ ], [ ], n);
        else
            errordlg('Enter a numeric value','Type Error');
        end
        
    % Apply Negative Transfromation
    case 'Negative'
        outputImage = imcomplement(inputImage);
        
    % Apply Piecewise-Linear process
    case 'Piecewise-Linear'
        % Check for RGB images
        if size(inputImage,3) == 3
            errordlg('Image have to be in Gray-Scale','Image Type Error');
        else
            % Get boundaries and vlaue from user
            input = inputdlg({'Start:', 'End:', 'Value'});
            n = str2double(input);
            if ~isnan(n)
                % pre-allocation
                outputImage = zeros(size(inputImage,1),size(inputImage,2));
                % slicing
                for i = 1:size(inputImage,1)
                    for j = 1:size(inputImage,2)
                       % if the pixel of the original image is in the specfied range 
                       % then make it c
                        if (inputImage(i,j) >= n(1) && inputImage(i,j) <= n(2))  
                            outputImage(i,j) = n(3);
                        else
                            % otherwise store the same value of the pixel in the result image
                            outputImage(i,j) = inputImage(i,j);
                        end
                    end
                end
            else
                errordlg('Enter a numeric value','Type Error');
            end
        end
        
    % Apply 1st Derivative for line detection     
    case '1st Derivative'
        if size(inputImage,3) == 3
            errordlg('Image have to be in Gray-Scale','Image Type Error');
        else
            outputImage = imgradientxy(inputImage);
        end
        
    % Apply 2st Derivative for line detection         
    case '2nd Derivative'
        second_derivative_filter = fspecial('laplacian', 0); 
        outputImage = imfilter(inputImage, second_derivative_filter);
        
    % Apply Canny operator for line detection         
    case 'Canny'
        % Check RGB images
        if size(inputImage,3) == 3
            errordlg('Image have to be in Gray-Scale','Image Type Error');
        else
            outputImage = edge(inputImage,'canny');
        end
        
    % Apply Hough Transformation for line detection            
    case 'Houghtransform'
        % Check RGB images
        if size(inputImage,3) == 3
            errordlg('Image have to be in Gray-Scale','Image Type Error');
        else
            % Apply Canny operator
            BW = edge(inputImage,'canny');
            % Apply Hough Transformation 
            [H,theta,rho] = hough(BW,'RhoResolution',0.5,'ThetaResolution',0.5);
            % Get peaks position
            peaks = houghpeaks(H,50,'Threshold',30);
            % Get lines position
            lines = houghlines(BW,theta,rho,peaks, 'FillGap',10,'MinLength',30);
            % Plot lines on image
            f = figure('visible', 'off');
            imshow(inputImage), hold on
            for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            line(xy(:,1),xy(:,2),'LineWidth',1,'Color','r');
            end
            frame = getframe(f);
            % Save the modified -with lines- image
            outputImage = frame2im(frame);
            % Show lines number
            set(handles.text3, 'visible','on');
            text = sprintf('%d lines.', length(lines));
            set(handles.text3, 'String',text);
        end
        
    % Apply Histogram equalization process
    case 'Histogram equalization'
        outputImage = histeq(inputImage);
end

% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in rgb2grayButton.
function rgb2grayButton_Callback(hObject, eventdata, handles)
% Invoke global variables              
global inputImage;
% Convert RGB image to gray scale one
inputImage = rgb2gray(inputImage);
% Show image and its histogram
imshow(inputImage, 'Parent', handles.axes1);
axes(handles.axes3), imhist(inputImage);
set(handles.rgb2grayButton, 'enable','off');

% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% Invoke global variables
global outputImage;
% Get the name and path for the output image to be saved
[name,path] = uiputfile('*.jpg');
if isequal(name, 0) || isequal(path, 0) || isequal(outputImage, 0)
    errordlg('There is no specified destination or name.','Error');
else
    % Save the image
    fullname = fullfile(path, name);
    imwrite(outputImage, fullname);
end
