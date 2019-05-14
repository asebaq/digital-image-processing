% Computes the correlation between template and input image
% and its output is a string containing the letter.
% Size of 'image' must be 42 x 42 pixels.

function [letter, found] = read_letter_a(image)
% Invoke global variables
global atemplate
% Pre-allocation for speed
result = zeros(1, 4*length(atemplate));
temp = atemplate{1, 1};
% Computes the correlation for all angles
for i = 1 : 4
    result(i) = corr2(temp,image);
    image = imrotate(image,90);
end
% Find the maximum match
result = max(result(:));
% Determine whether the letter is in the image or not
if round(result,1) >= 0.5
    letter = 'A';
    found = true;
else
    letter = '';
    found = false;
end
end