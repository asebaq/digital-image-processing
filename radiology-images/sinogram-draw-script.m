warning('off','all')
im4 = imread('1.jpg');

figure, imshow(im4);


th = 0:1:179;
figure, imshow(iradon(radon(im4, th), th, 'none'),[]);
figure, imshow(iradon(radon(im4, th), th),[]);
sinogram(im4);


d = (sqrt(size(im4,1)^2 + size(im4,2)^2)/2) + 43;
figure, imshow(ifanbeam(fanbeam(im4, d), d),[]);

