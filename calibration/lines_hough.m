clc; clear all; close all;
%function answer=hough(image)

% ROZMIAR OBRAZKA WPISANY NA SZTYWNO TRZEBA INNY

% funkcja zwracaj¹ca wykryte proste na obrazie
%I  = imread('HD_1080p/ocena_kalibracji/after_calib_tiles_10mm.png');
I  = imread('HD_1080p/ocena_kalibracji/after_calib_chess_10mm.png');
%I  = imread('HD_1080p/ocena_kalibracji/pattern.png');



%% params
L=length(I);
N=8    % liczba linii ( szukanych extremów ) 

image= rgb2gray(I);


%% Hough

BW = edge(image,'canny');

[H,T,R] = hough(BW ,'RhoResolution',0.5,'ThetaResolution',0.5);

% create hough trafo 
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%  find peaks
P  = houghpeaks(H,N,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
hold on;
title('hought space')


%%         L I N I E    W Y Z N A C Z O N E   Z:   HOUGHLINES()

% %  plot lines
% lines = houghlines(BW,T,R,P);%,'FillGap',5,'MinLength',7);
% figure, imshow(BW), hold on
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%    hold on;
%    title('linie wyznaczone przy pomocy transformacji hougha')
% 
% %    % Plot beginnings and ends of lines
% %    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
% %    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% % 
% %    % Determine the endpoints of the longest line segment
% %    len = norm(lines(k).point1 - lines(k).point2);
% %    if ( len > max_len)
% %       max_len = len;
% %       xy_long = xy;
% %    end
% end


%%

%%       P R O S T E   W Y Z N A C Z O N E   Z   P A R A M E T R Ó W

figure, imshow(BW), hold on

% r=y(1);
% teta=2*pi*x(1)/360;
% 
% X=linspace(1,1163,1163);
% Y=(r-X*cos(teta))/sin(teta);

% plot(X, Y,'LineWidth',1,'Color','red')
% hold on 

%%
r=y+1;     %%%%%% +1
teta=2*pi*x/360;         % przeliczenie wektora k¹tów na radiany

X=linspace(1,L,L);
Y=zeros(L,N);

for n=1:N
    if teta(n)==0
        Y(:,n)=(r(n)-X*cos(teta(n)))/(sin(teta(n))+1e-10)+2;   %%%%%%
    else
        Y(:,n)=(r(n)-X*cos(teta(n)))/sin(teta(n))+2;      %%%%%%%%%%%  +2
    end
end

plot(X, Y,'LineWidth',1,'Color','red')
hold on 

ind=1; xc=[]; yc=[];

for n=1:N
    for m=n:N
        if abs(abs(teta(n))-abs(teta(m)))>0.2
        [xc(ind), yc(ind)]=common(r(n),r(m),teta(n),teta(m));
        ind=ind+1;
        end
    end
end

    




