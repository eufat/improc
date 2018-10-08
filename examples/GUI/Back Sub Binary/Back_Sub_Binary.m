clc;
close all;
clear;
 
% Baca Citra Background
Background=imread('background.jpg');
 
% Baca Citra Current Frame
CurrentFrame=imread('original.jpg');
 
% Konversi Citra menjadi grayscale
Background_gray = rgb2gray(Background);
CurrentFrame_gray = rgb2gray(CurrentFrame);
 
% Konversi Citra menjadi biner menggunakan metode Otsu
Background_bw = im2bw(Background_gray,graythresh(Background_gray));
CurrentFrame_bw = im2bw(CurrentFrame_gray,graythresh(CurrentFrame_gray));
 
% Pengurangan Citra biner
Subtraction = Background_bw~=CurrentFrame_bw;
 
% Operasi Morfologi
bw = imdilate(Subtraction,strel('square',20));
bw = imclearborder(bw);
bw = bwareaopen(bw,5000);
 
% Pembuatan masking dan proses cropping
[row,col] = find(bw==1);
h_bw = imcrop(CurrentFrame,[min(col) min(row) max(col)-min(col) max(row)-min(row)]);
[a,b] = size(bw);
mask = false(a,b);
mask(min(row):max(row),min(col):max(col)) = 1;
mask =  bwperim(mask,8);
mask = imdilate(mask,strel('square',3));
R = CurrentFrame(:,:,1);
G = CurrentFrame(:,:,2);
B = CurrentFrame(:,:,3);
 
R(mask) = 255;
G(mask) = 0;
B(mask) = 0;
 
RGB = cat(3,R,G,B);
figure, imshow(RGB);