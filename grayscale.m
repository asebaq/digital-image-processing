function gray_image = grayscale(rgb_image, style)

[row, col, color_channels] = size(rgb_image);

if color_channels  == 3    % It's rgb colored image
    % slicing the color channels
    red = rgb_image(:, :, 1);
    green = rgb_image(:, :, 2);
    blue = rgb_image(:, :, 3);
    
    % Choose the style of grayscale
    switch style
        case 1
            % Convert the image to lightness grayscale
            gray_image = zeros(row, col);
            for i = 1 : row*col
                    gray_image(i) =(max(max(red(i), green(i)), blue(i))+ ...
                           min(min(red(i), green(i)), blue(i)))/2;
            end
        case 2
            % Convert the image to avergae grayscale
            gray_image = (red + green + blue)/3;
        case 3
            % Convert the image to luminosity grayscale
            gray_image = 0.21*double(red) + ...
                      0.72*double(green) + ...
                      0.07*double(blue);
    end
    
    % Convert the image back to uint8
    gray_image = uint8(gray_image);
    
else
    % It's not rgb colored image or already gray scale.
    gray_image = rgb_image;  
end

end