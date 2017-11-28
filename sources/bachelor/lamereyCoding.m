clear

nTransient = 10;
nCalc = 10000;
X = zeros(1,nCalc);
Y = zeros(1,nCalc);

global x s
alphabetSize = 32;

alpha = 0.001;

data1 = ['€беда'; 'плинк'];
data2 = ['€беда'; '€русы'];

x = 0 : 0.1 : 1;
y = x;
s = 1/2;

figure
plot(x,y,'r');
hold on;
grid

plotData1 = Calculator(data1, alphabetSize);
plotData2 = Calculator(data2, alphabetSize);

plot(plotData2(1,:), plotData2(2,:), 'k')

x1 = 0.0015;
y1 = 0.8741;
% y1 = alphabetSize*rand;

for r = 1:nTransient
    x1 = Iterator(x1, plotData1);
    disp(char(y1*alphabetSize+double('а')));
    y1 = Iterator(y1, plotData2);
end

X(1) = x1;
Y(1) = y1;
for r = 2:nCalc
    X(r) = Iterator(X(r-1), plotData1);
    Y(r) = Iterator((1-alpha)*Y(r-1) + alpha*X(r-1), plotData2);
end

disp(char(X*alphabetSize+double('а')));
disp(char(Y*alphabetSize+double('а')));

xLamerey=[X; X];
xLamerey=xLamerey(:);
yLamerey=[xLamerey(2:end); xLamerey(end)];

plot(xLamerey, yLamerey, 'g');

xLamerey=[Y; Y];
xLamerey=xLamerey(:);
yLamerey=[xLamerey(2:end); xLamerey(end)];

plot(xLamerey, yLamerey, 'b');