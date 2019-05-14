% Function to clip data in image
function outputImage = clip(inputImage)
[row, col] = find(inputImage);
% Crops image
outputImage = inputImage(min(row):max(row), min(col):max(col));
