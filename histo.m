function [freq, g_level] = histo(g_img)

% pre-allocation (for speed purposes)
freq = zeros(1, 256);
pixels_num = size(g_img,1) * size(g_img,2);

% get pixels count for each intensity leve
for i = 1 : pixels_num
    intensity_value = g_img(i)+1;
    freq(intensity_value) = freq(intensity_value)+1;
end
        
% plot the histogram.
g_level = 0 : 255;
bar(g_level, freq, 'hist');
xlim([0,255]);
ylim([1, max(freq)]);
xlabel('Gray Levels');
ylabel('Pixel Count');
title('Histogram');
grid on;
grid minor;
end