clc;
clear all;

%% reading into rgb and normalising
img = rgb2gray(imread('1.1.png'));
img_norm = (double(img-min(img(:)))/double(max(img(:)-min(img(:)))).*255);
% figure,imagesc(img_norm),colormap('gray'),title 'original Img';

%% otsu thresholding
level = graythresh(img_norm);
imgThresh = im2bw(img,level);
figure, imshow(imgThresh);title('Thresholded Image');

imgMasked = imgThresh.*1;
imgMasked = imgMasked.*img_norm;
figure, imagesc(imgMasked);colormap(gray),title('masked with thresholded Image');

%%
SE= strel('disk',5);
Ierosion= imerode(imgThresh, SE);
Idilation= imdilate(imgThresh, SE);
% figure, imagesc(Ierosion);colormap(gray),title('eroded Image');
% figure, imagesc(Idilation);colormap(gray),title('dilated Image');

%%
cartilage = bwareaopen(imgThresh, 4000);
figure,imshowpair(img_norm,cartilage), title('area opening');