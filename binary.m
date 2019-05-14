function binary_image = binary(gray_image, threshold)
% Convert a gray scale image to a binary image by using a threshold
binary_image = gray_image >= threshold;