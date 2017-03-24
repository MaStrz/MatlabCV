clc; clear all; close all;
%% Program kalibracji kamery lub wczytania jej gotowych parametrów.
    % wizualizacja efektu poprzez transformacjê zdeformowanego obrazu
    % w punkcie (example of lens distortion removing)

%% calibration
%[cameraParams, imagesUsed, estimationErrors]=calib();

%% ready parameters
%load('HD_1080p/chess_26mm/params.mat');
load('HD_1080p/chess_10mm/params.mat');

%% example of lens distortion removing
%I=imread('HD_1080p/photos/HD_18_im2.JPG');
I=imread('HD_1080p/photos/HD_18_im12.JPG');
[J,newOrigin] = undistortImage(I,cameraParams);

figure; imshow(I); hold on; 
title('dupa zbita')

figure; imshow(J); hold on; 
%title('po usuniêciu deformacji')



%%

