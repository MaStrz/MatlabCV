clc; clear all; close all;

%   Program wizualizuje po³o¿enie kamery wzglêdem szachownicy oraz wylicza macierz Rotacji, wektor Translacji
% i po³o¿enie po¿¹danej pozycji w uk³adzie odniesienia zwi¹zanym z kamer¹. 

%   Problem wci¹¿ sprawia interpretacja wyników. Otrzymany wykres 3D przedstawia wzajemne po³o¿enie kamery oraz szachownicy.
% Jest poprawny dziêki odwróceniu osi pionowej oraz jednej z osi poziomych. 

    
%% Loading camera params and image

load('..\..\kalibracja\HD_1080p\chess_10mm\params.mat');
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

%%  POSITION IN CAMERA COORDS
WorldCoords = [52 52 -104];
plot3(WorldCoords(1),WorldCoords(2),WorldCoords(3),'r*')
xlabel('x [mm]'); ylabel('y [mm]'), zlabel('z [mm]')

camCoords= WorldCoords* rotationMatrix + translationVector




%%  Final computing of desired position in NED coords

% GLOBAL_POSITION_INT ( #33 )  gives information about vehicle heading - 
%                              (yaw angle) in degrees * 100, 0.0..359.99 degrees

%samle value:
hdg=3000;   % 30 degrees

teta= hdg/100 * 2*pi / 360;

R=[cos(teta), 0, sin(teta);
        0,      1,    0;
    -sin(teta), 0, cos(teta)] ;


NEDPose=R*camCoords'   % NED coords North, East, Down

% TUTAJ JEST TERAZ JESZCZE B£¥D, ZDAJE SIÊ ¯E TO X MA BYÆ DOWN A NIE Z, ! ! ! 

