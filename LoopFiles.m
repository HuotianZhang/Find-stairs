% Path to the folder containing the txt files
folderPath = '\\ad.liu.se\home\huozh22\Downloads\DC_Calibrate_lean\DC_Calibrate_lean\downsampling'; % Update this to your folder path
% Get a list of all txt files in the folder
files = dir(fullfile(folderPath, '*.txt'));

% Loop through each file
for k = 1:length(files)
    % Full path to the current file
    currentFilePath = fullfile(files(k).folder, files(k).name);
    
    % Read data from the current file
    % (Adjust the reading function and parameters as needed for your data format)
    data = readmatrix(currentFilePath);
    [smoothedSignal, Positions, Values, Index] = Findstairs(data);
    % Prepare output data in sequence of stair index, position and values
    result = [(1:Index)' Positions Values];
    % --- Process the data here ---
    % Example: data = data * 2; % This is a placeholder for your processing steps
    
    % Define the header
    header = sprintf('Total stairs: %d', Index);
    
    % Define the path for the processed file
    % Append '_processed.txt' to the original file name
    [pathstr, name, ext] = fileparts(currentFilePath);
    processedFilePath = fullfile(pathstr, [name '_result' ext]);
    
    % Open the processed file for writing
    fileID = fopen(processedFilePath, 'w');
    
    % Write the header
    fprintf(fileID, '%s\n', header);
    
    % Write the processed data
    % (Adjust the format specifier '%f' as needed for your data)
    for row = 1:size(result, 1)
        fprintf(fileID, '%d %.1f %.1f\n', result(row, :)); % Example for writing numeric data
    end

    % Close the file
    fclose(fileID);

    % Create a figure in background
    fig = figure('Visible', 'off');
    
    % Plot
    plot(data, 'b-', 'DisplayName', 'Original Signal');
    hold on;
    plot(smoothedSignal, 'r-', 'DisplayName', 'Smoothed Signal');
    legend('show');
    
    % Highlight changes
    plot(Positions, Values, 'kx', 'MarkerSize', 3, 'LineWidth', 0.5, 'DisplayName', 'Stair Changes');
    title('Signal with Detected Stairs');
    xlabel('Data Point');
    ylabel('Signal Value');

    % Save the plot to a PNG file
    figFilePath = fullfile(pathstr, [name '.png']);
    saveas(fig, figFilePath);
    
   
    % Close the figure
    close(fig);

end