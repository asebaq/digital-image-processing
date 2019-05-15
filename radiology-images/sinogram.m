function out = sinogram(img)

img = imresize(img, [100 100]);
iptsetpref('ImshowAxesVisible','on');
th = 0:180;
[out, xp] = radon(img, th);
figure, imshow(out, [], 'Xdata', th, 'Ydata', xp,...
    'InitialMagnification', 'fit');
xlabel('\theta (degrees)');
ylabel('x''');
colormap(gray), colorbar
iptsetpref('ImshowAxesVisible','on');