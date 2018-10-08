gambar=imread('kucing.jpg');
red=gambar(:,:,1);
green=gambar(:,:,2);
blue=gambar(:,:,3);


figure, imshow(gambar)
figure, imshow(red)
figure, imshow(green)
figure, imshow(blue)