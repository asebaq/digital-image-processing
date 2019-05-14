function outputImage = drawRect( inputImage, temp )
% Convert to gray scale
if size(inputImage,3)== 3
    image = rgb2gray(inputImage);
end

% Convert to BW
threshold = graythresh(image);
image = ~imbinarize(image,threshold);

% Remove all object containing fewer than 30 pixels
image = bwareaopen(image,30);

% NXC for the found letter and the processed image
nxc = normxcorr2(temp(:,:,1),image(:,:,1));
imax = find(nxc == max(abs(nxc(:))));
% Draw red rectangle around the letter
f = figure('visible', 'off');
imshow(inputImage); hold on;
for i = 1 : length(imax)
    [ypeak, xpeak] = ind2sub(size(nxc),imax(i));
    corr_offset = [(xpeak-size(temp,2)) (ypeak-size(temp,1))];
    rectangle('position',[corr_offset(1) corr_offset(2)...
               size(temp,2) size(temp,1)],...
              'edgecolor','r','linewidth',1);
end
hold off;
frame = getframe(f);
% Save the modified -with lines- image
outputImage = frame2im(frame);
close(f);
end

