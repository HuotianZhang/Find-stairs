function interpolateCallback(src, event)
    fig = src.Parent;
    yValueStr = fig.UserData.yValueEdit.String;
    yValue = str2double(yValueStr);

    % Validate numerical input
    if isnan(yValue)
        errordlg('Please enter a valid numerical Y value.', 'Invalid Input');
        return;
    end

    data = fig.UserData.data;

    % Ensure data is loaded
    if isempty(data)
        errordlg('Please load data first.', 'No Data Loaded');
        return;
    end


    % Ensure Y values are unique for interpolation
    [uniqueY, ia, ic] = unique(data(:,2), 'stable');
    if length(uniqueY) < length(data(:,2))
        % Handle non-unique Y values by averaging corresponding X values
        meanXForEachY = accumarray(ic, data(:,1), [], @mean);
        dataForInterp = [meanXForEachY, uniqueY];
    else
        % If all Y values are already unique, use the data as is
        dataForInterp = data;
    end

 

    % Check if yValue is within the range
    minY = min(dataForInterp(:,2));
    maxY = max(dataForInterp(:,2));
    if yValue < minY
        message = sprintf('Current>%d uA', dataForInterp(end-1,1));
    elseif yValue > maxY
        message = sprintf('Current<%d uA', dataForInterp(2,1));
    else
        % Perform interpolation
        xInterpolated = interp1(dataForInterp(:,2), dataForInterp(:,1), yValue, 'linear');
        message = sprintf('Current (uA): %.2f', xInterpolated);
        % Mark the interpolated point on the plot
        hold(fig.UserData.ax, 'on');
        plot(fig.UserData.ax, xInterpolated, yValue, 'ro');
        hold(fig.UserData.ax, 'off');
    end

    % Update the label to show interpolated X or range info
    fig.UserData.interpolatedXLabel.String = message;
end
