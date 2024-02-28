% Specify the path to your file
filePath = "\\ad.liu.se\home\huozh22\Downloads\Sectioned+dry\Sectioned+dry\Sweep-20um+-800um_new_dry.txt"; % Update this to your file path

% Read the data (assuming numeric data and space delimiter)
data = readmatrix(filePath);

% Get the base file name without extension for naming the output files
[pathstr, name, ~] = fileparts(filePath);

% Loop through each column of the data
for col = 1:size(data, 2)
    % Extract the current column
    columnData = data(:, col);
    
    % Define the output file name based on the original name and current column
    outputFileName = fullfile(pathstr, sprintf('%s_%d.txt', name, col-1));
    
    % Save the current column to a file
    writematrix(columnData, outputFileName);
end
