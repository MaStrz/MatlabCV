clc; clear all; close all;
%% zbieranie i akwizycja danych dla funkcji zwracaj¹cej wektor przesuniêcia
    % 06.02.17 - brak funkcji CameraPose (zaimplementowaæ lub upgrade
    % matlaba)

%image=imread('pose0.png');
image=imread('exp_10.03/po_01.png');
figure
imshow(image); hold on;
matchedPoints1=get_points(20);

inlierPoints1=get_points(3);
plot(inlierPoints1(1:2,1),inlierPoints1(1:2,2),'r',inlierPoints1(2:3,1),inlierPoints1(2:3,2),'g')

%image=imread('pose1.png');
image=imread('exp_10.03/po_02.png');
figure
imshow(image); hold on;
%matchedPoints2=get_points(20);
matchedPoints2=load('exp_10.03/matchedPoints02')

inlierPoints2=get_points(3);
plot(inlierPoints2(1:2,1),inlierPoints2(1:2,2),'r',inlierPoints2(2:3,1),inlierPoints2(2:3,2),'g')



M = estimateFundamentalMatrix(matchedPoints1,matchedPoints2)
%load('experiment_10.03/FundamentalMatrix02.mat')
load('X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\params.mat')

[relativeOrientation,relativeLocation] = cameraPose(M,cameraParams,inlierPoints1,inlierPoints2)

