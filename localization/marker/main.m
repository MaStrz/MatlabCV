clc; clear all; close all;
%% 
image=imread('pose1.png');

figure
imshow(image)
hold on;

points=get_points();
X=points(:,1);
Y=points(:,2);

plot(X(1:2),Y(1:2),'r',X(2:3),Y(2:3),'g')