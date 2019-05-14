% OCR (Optical Character Recognition).
function [letter, found, outputImage] = ocr_a(inputImage)

% Convert to gray scale
if size(inputImage,3)== 3
    image = rgb2gray(inputImage);
end

% Convert to BW
threshold = graythresh(image);
image = ~imbinarize(image,threshold);

% Remove all object containing fewer than 30 pixels
image = bwareaopen(image,30);

temp = image;

% Create and load template
a_template
global atemplate
load atemplate
found = false;
flag = 0;
while ~found
    % separate lines in text
    [fl, temp] = lines(temp);
    newImage = fl;

    % Label and count connected components
    [l, n] = bwlabel(newImage);    
    for i = 1:n
        [row, col] = find(l == i);
        
        % Extract letter
        letterImage = newImage(min(row):max(row), min(col):max(col));  

        % Resize letter (same size of template)
        newLetterImage = imresize(letterImage,[42 42]);

        % Read letter image
        [letter, found] = read_letter_a(newLetterImage);
        if found
            flag = flag + 1;
            outputImage = drawRect(inputImage, letterImage);
            break;
        else
            outputImage = 0;
        end
    end
    
    if isempty(temp)  
        break
    end    
    
end

