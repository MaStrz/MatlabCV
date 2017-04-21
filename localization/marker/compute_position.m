clc; clear all; close all;

%   Program wizualizuje po³o¿enie kamery wzglêdem szachownicy oraz wylicza macierz Rotacji, wektor Translacji
% i po³o¿enie po¿¹danej pozycji w uk³adzie odniesienia zwi¹zanym z kamer¹. 

%   Problem wci¹¿ sprawia interpretacja wyników. Otrzymany wykres 3D przedstawia wzajemne po³o¿enie kamery oraz szachownicy.
% Jest poprawny dziêki odwróceniu osi pionowej oraz jednej z osi poziomych. 

    
%% Loading camera params and image

load('..\..\calibration\HD_1080p\chess_10mm\params.mat');
imOrig=imread('chess\HD_18_archi.JPG');
im = undistortImage(imOrig,cameraParams);

figure
imshow(im);

%% Board detecting and ploting

[imagePoints, boardSize] = detectCheckerboardPoints(im);
squareSize = 26;
worldPoints = generateCheckerboardPoints(boardSize,squareSize);

[imagePoints,boardSize] = detectCheckerboardPoints(im);


figure;
plot3(worldPoints(:,1),worldPoints(:,2),zeros(size(worldPoints, 1),1),'*');
hold on

%% Computing rotation matrix and translation vect

[rotationMatrix,translationVector] = extrinsics(imagePoints,...
    worldPoints,cameraParams);

%% Marking the origin

plot3(0,0,0,'g*');

%% Camera position

orientation = rotationMatrix';
location = -translationVector * orientation;

cam = plotCamera('Location',location,'Orientation',orientation,'Size',20);
set(gca,'CameraUpVector',[0 0 -1]);
set(gca,'Xdir','reverse')

%%
WorldCoords = [52 52 -104];
plot3(WorldCoords(1),WorldCoords(2),WorldCoords(3),'r*')

camCoords= WorldCoords* rotationMatrix + translationVector





