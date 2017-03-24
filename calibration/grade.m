%% Funkcja wyznaczaj¹ca gradient zadanego obrazu

function [vertic,horiz,mod_grad]=grade(image)

h0=[-1,-2,-1;
    0, 0, 0;
    1, 2, 1];

h1=[-1,0,1;
    -2,0,2;
    -1,0,1];

vertic=imfilter(image,h0);
horiz=imfilter(image,h1);

% vertic=vertic/norm(vertic);
% horiz=horiz/norm(horiz);

mod_grad=sqrt(vertic.^2+horiz.^2);
mod_grad=mod_grad/norm(mod_grad);

