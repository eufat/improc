I = imread('kucing.jpg');
gray=rgb2gray(I);

BW1 = edge(gray, 'prewitt');
BW2 = edge(gray, 'canny');
BW3 = edge(gray, 'sobel');
BW4 = edge(gray, 'roberts');

figure, imshow(BW1);
figure, imshow(BW2);
figure, imshow(BW3);
figure, imshow(BW4);