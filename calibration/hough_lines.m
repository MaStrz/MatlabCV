function [xc,yc]=hough_lines(BW,N,L)

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
title('title');



%%


%%       P R O S T E   W Y Z N A C Z O N E   Z   P A R A M E T R Ó W



%%
figure(1)

r=y;     %%%%%% +1
teta=2*pi*x/360;         % przeliczenie wektora k¹tów na radiany

X=linspace(0,L,L);
Y=zeros(L,N);

for n=1:N
    if teta(n)==0
        Y(:,n)=(r(n)-X*cos(teta(n)))/(sin(teta(n))+1e-10)+1;   %%%%%%
    else
        Y(:,n)=(r(n)-X*cos(teta(n)))/sin(teta(n))+1;      %%%%%%%%%%%  +2
    end
end

plot(X+1, Y,'LineWidth',1,'Color','red')
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