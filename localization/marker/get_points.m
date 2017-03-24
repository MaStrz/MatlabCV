function points=get_points(n)
%% 

X=[]; Y=[];
button = 1;

p=[];



for k=1:n
    [x,y] = ginput(1);
    X=[X x] ; Y=[Y y];
    hold on;
    if ~isempty(p)
        delete(p);
    end

    p=plot(X,Y,'r.')

end

points=[X' Y']