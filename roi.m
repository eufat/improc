gambar=imread('kucing.jpg');
I=gambar(:,:,1);
c = [222 272 300 270 221 194];
r = [21 21 75 121 121 75];
BW = roipoly(I,c,r);
j = roifill(I,c,r);

figure, imshow(I);
figure, imshow(BW);
figure, imshow(j);