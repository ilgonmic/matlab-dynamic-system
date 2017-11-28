function y = Iterator( x, plotData )

    xPlot = plotData(1, :);
    yPlot = plotData(2, :);
    for i = 1 : length(xPlot) - 1
        if (xPlot(i) <= x && x < xPlot(i + 1))
            k = (yPlot(i + 1) - yPlot(i))/(xPlot(i + 1) - xPlot(i));
            b = yPlot(i) - k*xPlot(i);
            y = k*x + b;
            return;
        end
    end
    
    y = 0;

end