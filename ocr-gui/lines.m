% Function to divide text in lines
function [firstLine, lastLine] = lines(inputImage)
% Crop input image to get data only
inputImage = clip(inputImage);
row = size(inputImage,1);
% Loop through text line by line
for i = 1:row
    if sum(inputImage(i,:)) == 0 % line start
        fl = inputImage(1:i-1, :); % First line 
        ll = inputImage(i:end, :); % Last line 
        % Crop image into lines
        firstLine = clip(fl);
        lastLine = clip(ll);
        break
    else
        % Only one line
        firstLine = inputImage;
        lastLine = [ ];
    end
end

