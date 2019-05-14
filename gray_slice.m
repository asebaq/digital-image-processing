function sliced_img = gray_slice(gray_img, a, b, c)

[row, col]= size(gray_img);

% pre-allocation (for speed purposes)
sliced_img = zeros(row,col);

% slicing
for i = 1:row
    for j = 1:col
       % if the pixel of the original image is in the specfied range 
       % then make it c
        if (gray_img(i,j) > a && gray_img(i,j) < b)  
            sliced_img(i,j) = c;
        else
       % otherwise store the same value of the pixel in the result image
            sliced_img(i,j) = gray_img(i,j);
        end
    end
end

% show images
subplot(121),imshow(uint8(gray_img)); title('Original image');
subplot(122),imshow(uint8(sliced_img)); title('Sliced image');

end

