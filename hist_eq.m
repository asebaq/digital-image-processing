function new_img = hist_eq(g_img)

% pre-allocation (for speed purposes)
new_img = uint8(zeros(size(g_img,1),size(g_img,2)));
freq = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
cum = zeros(256,1);
equalization = zeros(256,1);

pixels_num = size(g_img,1) * size(g_img,2);
total = 0;
levels_num = 255;

% get pixels count for each intensity leve 
% and Calculate the probability density function
for i = 1:size(g_img, 1)
    for j = 1:size(g_img, 2) 
        intensity_value = g_img(i,j)+1;
        freq(intensity_value) = freq(intensity_value)+ 1;
        pdf(intensity_value) = freq(intensity_value)/pixels_num;
    end
end

% Calculate the cumulative distribution probability
for i = 1:size(pdf)
   total = total + freq(i);
   cum(i) = total;
   cdf(i) = cum(i)/pixels_num;
   equalization(i) = round(cdf(i)* levels_num);
end

% Create an equalized image
for i = 1:size(g_img,1)
    for j = 1:size(g_img,2)
        new_img(i,j) = equalization(g_img(i,j));
    end
end

subplot(121); imshow(g_img); title('Original image');
subplot(122); imshow(new_img); title('Equalized image');

end