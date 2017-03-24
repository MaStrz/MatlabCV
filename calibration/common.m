function [x,y]=common(r1,r2,teta1,teta2)
%r1=r(1); teta1=teta(1);
%r2=r(7); teta2=teta(7);

a=[cos(teta1) sin(teta1); cos(teta2) sin(teta2)];
r=[r1;r2];
A=inv(a)*r;
x=A(1)+1; y=A(2)+1;
plot(x,y,'g+');


