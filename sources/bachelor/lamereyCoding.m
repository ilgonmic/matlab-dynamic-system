clear

nTransient = 0;
nCalc = 100000;
X = zeros(1,nCalc);
Y = zeros(1,nCalc);

global x s
alphabetSize = 32;

alpha = 0.97;
beta = 1 - alpha;

data1 = ['магия'];
data2 = ['магия'; 'супер'];

x = 0 : 1 : alphabetSize;
y = x;
s = 1/2;

figure
plot(x,y,'r');
grid;
hold on;

plotData1 = Calculator(data1, alphabetSize);
plotData2 = Calculator(data2, alphabetSize);

% plot(plotData2(1,:), plotData2(2,:), 'b'), grid

x1 = 0.5;
y1 = 5.5;

for r = 1:nTransient
    x1 = Iterator(x1, plotData1);
    y1 = Iterator(y1, plotData2);
end

X(1) = x1;
Y(1) = y1;
for r = 2:nCalc
    X(r) = Iterator(X(r-1), plotData1);
    Y(r) = Iterator((1-alpha)*Y(r-1) + alpha*X(r-1), plotData2);
end

disp(char(X+double('а')));
disp(char(Y+double('а')));

xLamerey=[X; X];
xLamerey=xLamerey(:);
yLamerey=[xLamerey(2:end); xLamerey(end)];

plot(xLamerey, yLamerey, 'g');

xLamerey=[Y; Y];
xLamerey=xLamerey(:);
yLamerey=[xLamerey(2:end); xLamerey(end)];

plot(xLamerey, yLamerey, 'b');