function selectFileCallback(src, event)
    [file, path] = uigetfile('*.txt', 'Select a file');
    if isequal(file, 0)
        disp('User selected Cancel');
    else
        fullPath = fullfile(path, file);
        data = load(fullPath); % Assuming the file is .txt with numeric data
        % Store data for later use
        fig = src.Parent;
        fig.UserData.data = data;
        % Plot data with reversed roles
        ax = fig.UserData.ax;
        plot(ax, data(:,1), data(:,2), 'LineWidth', 2); % Reversed X and Y
        xlabel(ax, 'Current (uA)');
        ylabel(ax, 'Signal');
        title(ax, file);
    end
end
