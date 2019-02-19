clear

nTransient = 100;
nCalc = 1000;
X = zeros(1,nCalc);
Y = zeros(1,nCalc);

global x s
alphabetSize = 32;

alpha = 0.001;

data = ['мурка'];
data2 = ['норка'];

x = 0 : 0.1 : 1;
y = x;
s = 1/2;

figure
plot(x,y,'r');
hold on;
grid

plotData = Calculator(data, alphabetSize);

plot(plotData(1,:), plotData(2,:), 'k')

x1 = 0.0122;

for r = 1:nTransient
    x1 = Iterator(x1, plotData);
end

X(1) = x1;
for r = 2:nCalc
    X(r) = Iterator(X(r-1), plotData);
end

disp(char(X*alphabetSize+double('а')));

xLamerey=[X; X];
xLamerey=xLamerey(:);
yLamerey=[xLamerey(2:end); xLamerey(end)];

plot(xLamerey, yLamerey, 'g');

% ========

figure
plot(x,y,'r');
hold on;
grid

plotData2 = Calculator(data2, alphabetSize);

plot(plotData2(1,:), plotData2(2,:), 'k')

x1 = 0.0122;

for r = 1:nTransient
    x1 = Iterator(x1, plotData2);
end

X(1) = x1;
for r = 2:nCalc
    X(r) = Iterator(X(r-1), plotData2);
end

disp(char(X*alphabetSize+double('а')));

xLamerey2=[X; X];
xLamerey2=xLamerey2(:);
yLamerey2=[xLamerey2(2:end); xLamerey2(end)];

plot(xLamerey2, yLamerey2, 'g');

% =======

figure
[Xp,Yp] = meshgrid(plotData(1, :), plotData2(1, :));

for q = 1:length(Xp)
    for w = 1:length(Yp)
        Z(q, w) = plotData(2, q) + plotData2(2, w);
    end
end

surf(Xp, Yp, Z)