clc;
close all;
clear;
 
%Read Background Image
Background=imread('background.jpg');
 
%Read Current Frame
CurrentFrame=imread('original.jpg');
 
% Display Background and Foreground
subplot(2,2,1);imshow(Background);title('Background');
subplot(2,2,2);imshow(CurrentFrame);title('Current Frame');
 
%Convert RGB 2 HSV Color conversion
[Background_hsv]=round(rgb2hsv(Background));
[CurrentFrame_hsv]=round(rgb2hsv(CurrentFrame));
Out = bitxor(Background_hsv,CurrentFrame_hsv);
 
%Convert RGB 2 GRAY
Out=rgb2gray(Out);
 
%Read Rows and Columns of the Image
[rows, columns]=size(Out);
 
%Convert to Binary Image
for i=1:rows
    for j=1:columns
        if Out(i,j) >0
            BinaryImage(i,j)=1;
        else
            BinaryImage(i,j)=0;
        end
    end
end
 
%Apply Median filter to remove Noise
FilteredImage=medfilt2(BinaryImage,[5 5]);
 
%Boundary Label the Filtered Image
[L, num]=bwlabel(FilteredImage);
 
STATS=regionprops(L,'all');
cc=[];
removed=0;
 
%Remove the noisy regions
for i=1:num
    dd=STATS(i).Area;
    if (dd < 5000)
        L(L==i)=0;
        removed = removed + 1;
        num=num-1;
    end
end
 
L = logical(L);
[row,col] = find(L==1);
 
h_bw = imcrop(CurrentFrame,[min(col) min(row) max(col)-min(col) max(row)-min(row)]);
 
[a,b] = size(L);
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
 
%Display Result
subplot(2,2,3);imshow(L);title('Detected Foreground (binary)');
subplot(2,2,4);imshow(RGB);title('Detected Foreground (RGB)');