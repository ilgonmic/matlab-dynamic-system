function plotXY = Calculator( data, alphabetSize )

global x;
global s;
dataSize = size(data);
q = 0;
isDuplicates = 1;

data = double(data) - double('à')*ones(dataSize(1), dataSize(2));

while(isDuplicates == 1)
    isDuplicates = 0;
    q = q + 1;
    for i = 1 : dataSize(1)
        line = data(i, 1:end);
        tmp = line;
        for j = 2 : q+1
            lineWithShift = [line(j:end) line(1:j-1)];
            tmp = [tmp; lineWithShift];
        end
        if (i == 1)
            result = tmp;
        else
            result = [result tmp];
        end
    end
    
    result = result';
    
    for i = 1 : dataSize(1)*dataSize(2) - 1
        zeros_rows = find(~sum(abs(result(:,1:q) - ones(dataSize(1)*dataSize(2),1)*result(i,1:q)),2));
        k = size(zeros_rows);
        if (k(1) > 1)
            isDuplicates = 1;
            break;
        end
    end
    
end

resultSize = size(result);

informationPlot = zeros(resultSize(1), 2);

for i = 1 : resultSize(1)
    tmpX = 0;
    tmpY = 0;
    for j = 1 : q
        tmpX = tmpX + result(i, j)/(alphabetSize^(j));
        tmpY = tmpY + result(i, j+1)/(alphabetSize^(j));
    end
    informationPlot(i, 1) = tmpX;
    informationPlot(i, 2) = tmpY;
end

[X, I] = sort(informationPlot(:,1));

Y = informationPlot(I, 2);

delta = x(2) - x(1);

for i = 1 : length(informationPlot)
    X(i) = X(i) + delta/(alphabetSize^(q))/2;
    Y(i) = Y(i) + s*delta/(alphabetSize^(q))/2;
end

xPlot = zeros(1, 2 * 10 * alphabetSize^q);
yPlot = zeros(1, 2 * 10 * alphabetSize^q);

% accuracy = (x(2) - x(1))/(alphabetSize^(q+1));
accuracy = 0;

j = 1;

for i = 1 : 10 * alphabetSize^q
    unit = delta/(alphabetSize^(q));
    left = (i - 1) * unit;
    right = i * unit;
    if (j <= length(X) && left <= X(j) && X(j) < right)
        xPlot(2*i - 1) = left + accuracy;
        yPlot(2*i - 1) = Y(j) - s*unit/2 + accuracy*s;
        xPlot(2*i)     = right - accuracy;
        yPlot(2*i)     = Y(j) + s*unit/2 - accuracy*s;
        j = j + 1;
    else
        xPlot(2*i - 1) = left + accuracy;
        yPlot(2*i - 1) = 0 + accuracy*(1/unit);
        xPlot(2*i)     = right - accuracy;
        yPlot(2*i)     = 1 - accuracy*(1/unit);
    end
end

plotXY = [xPlot; yPlot];

end