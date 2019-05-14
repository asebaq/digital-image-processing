function edge_detected = edge_sobel_th(img)

% Sobel Gradient filters(x,y)
sobel_gradient_x = [0 1 2; -1 0 1; -2 -1 0];
sobel_gradient_y = [-2 -1 0; -1 0 1; 0 1 2];

% Average filter
avg = ones(5,5)/25;

% Apply Average filter
smoothing = imfilter(double(img), avg);
g = (max(smoothing(:)));
smoothed_img = smoothing/g;

% Apply Sobel Gradient filter
Gx_s3 = imfilter(double(smoothed_img), sobel_gradient_x, 'replicate');
Gy_s3 = imfilter(double(smoothed_img), sobel_gradient_y, 'replicate');
Mag_s3 = abs(Gx_s3) + abs(Gy_s3);

% Apply threshold of 33% of the maximum of the magnitude 
threshold = 0.33*(max(Mag_s3(:)));
Mag_th = (Mag_s3 >= threshold);

edge_detected = Mag_th;

% Show
subplot(231);imshow(img); title('Original image');
subplot(232);imshow(smoothed_img); title('Smoothed image');
subplot(233);imshow(Gx_s3); title('G_x image');
subplot(234);imshow(Gy_s3); title('G_y image');
subplot(235);imshow(Mag_s3); title('M image');
subplot(236);imshow(Mag_th); title('M_{th} image');

end