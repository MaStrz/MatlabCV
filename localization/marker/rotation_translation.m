clc; clear all; close all;


orientation=    [0.6796   -0.4380    0.5884;
                0.3012    0.8980    0.3206;
                -0.6688   -0.0406    0.7423];
            
location= [0.8853   -0.1137    0.4509];

%    orientation=     [0.3526   -0.3137   -0.8816;
%                      0.9199   -0.0566    0.3880;
%                     -0.1716   -0.9478    0.2686];
%                 
%    location =   [-0.4724   -0.4223    0.7736];

     


rotationMatrix = orientation';

translationVector =-location*orientation';

%% rotation angles


B=asin(-orientation(3,1));                              d_fi=B*360/(2*pi);
A=asin(orientation(3,2)/cos(B));                        d_om=A*360/(2*pi);
C=asin(orientation(2,1)/cos(B));                        d_te=C*360/(2*pi);

CHECK=[ cos(C)*cos(B)   -sin(C)*cos(A)+cos(C)*sin(B)*sin(A)   sin(C)*sin(A)+cos(C)*sin(B)*cos(A);
        sin(C)*cos(B)   cos(C)*cos(A)+sin(C)*sin(B)*sin(A)    -cos(C)*sin(A)+sin(C)*sin(B)*cos(A);
        -sin(B)         cos(B)*sin(A)               cos(B)*cos(A)]
    
%% new coords   ??

R=rotationMatrix; t=translationVector;

M=    [0.1 0.1 0.1]*R + t


