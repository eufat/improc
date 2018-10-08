gambar=imread('kucing.jpg');
red=gambar(:,:,1);
green=gambar(:,:,2);
blue=gambar(:,:,3);
I=rgb2gray(gambar);

%merahgrrr2=0.3*red+0.5*green+0.2*blue;

figure
subplot(2,2,1);
imhist(red);
subplot(2,2,2);
imhist(green);
subplot(2,2,3);
imhist(blue);
subplot(2,2,4);
imhist(I);