clc; clear all; close all;
%function answer=hough(image)

% ROZMIAR OBRAZKA WPISANY NA SZTYWNO TRZEBA INNY


%I  = imread('HD_1080p/ocena_kalibracji/after_calib_tiles_10mm.png');
I  = imread('HD_1080p/ocena_kalibracji/after_calib_chess_10mm.png');
%I  = imread('HD_1080p/ocena_kalibracji/pattern.png');


%% params
L=length(I);
N=8    % liczba linii ( szukanych extremów ) 

image= rgb2gray(I);


%% Hough

BW = edge(image,'canny');

figure(1)
%imshow(BW), hold on
imshow(I), hold on

figure(2),  
[x_g,y_g]=hough_lines(BW,N,L);   %  x_g,y_g - wspó³rzêdne przeciêæ globalnych linii H 
















%% WTF ?




figure(3)
imshow(I(round(y_g(2))-20:round(y_g(2))+20,round(x_g(2))-20:round(x_g(2))+20));
hold on,



    for n=1:length(x_g)
      [H,T,R] = hough(BW(round(y_g(n))-20:round(y_g(n))+20,round(x_g(n))-20:round(x_g(n))+20),'RhoResolution',0.5,'ThetaResolution',0.5);

         %  find peaks
        P  = houghpeaks(H,2,'threshold',ceil(0.3*max(H(:))));
        x = T(P(:,2)); y = R(P(:,1));
       
        r=y;     %%%%%% +1
        teta=2*pi*x/360;         % przeliczenie wektora k¹tów na radiany

%         
        if abs(abs(teta(1))-abs(teta(2)))>0.2
            figure(3)
            [xc(n), yc(n)]=common(r(1),r(2),teta(1),teta(2));
        end
        
        x_l(n)=xc(n)+round(x_g(n))-21;
        y_l(n)=yc(n)+round(y_g(n))-21;
        
       figure(1)
        plot(x_l(n),y_l(n),'gO')
        hold on;
    end
    
    
Y=y_l-y_g;
X=x_l-x_g;
    
dist=sqrt(Y.^2+X.^2);

ME=mean(dist);




