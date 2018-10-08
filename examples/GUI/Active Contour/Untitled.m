clc;clear;close all;
I = imread('airplane.jpg');         %-- load the image
J = rgb2gray(I);                    %-- convert rgb to grayscale
m = zeros(size(J,1),size(J,2));     %-- create initial mask
m(111:231,123:243) = 1;
seg = activecontour(J,m,350);       %-- Run segmentation
figure,
subplot(2,2,1);imshow(I);title('Input Image');
subplot(2,2,2);imshow(m);title('Initialization Mask');
subplot(2,2,3);imshow(seg);title('Active Contour Segmentation');
subplot(2,2,4);imshow(I);title('Active Contour Segmentation');
hold on
contour(seg, [0 0], 'y','LineWidth',2);