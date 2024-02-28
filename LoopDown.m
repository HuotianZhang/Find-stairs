% Path to the folder containing the txt files
folderPath = '\\ad.liu.se\home\huozh22\Downloads\DC_Calibrate_lean\DC_Calibrate_lean'; % Update this to your folder path
% Get a list of all txt files in the folder
files = dir(fullfile(folderPath, '*.txt'));

% Loop through each file
for k = 1:length(files)
    % Full path to the current file
    currentFilePath = fullfile(files(k).folder, files(k).name);
    
    % Read data from the current file
    % (Adjust the reading function and parameters as needed for your data format)
    data = downsampling(currentFilePath);
    
    % Define the path for the processed file
    % Append '_processed.txt' to the original file name
    [pathstr, name, ext] = fileparts(currentFilePath);
    processedFilePath = fullfile(pathstr, [name '_downsampling' ext]);
    
    % Open the processed file for writing
    fileID = fopen(processedFilePath, 'w');
    
    % Write the processed data
    % (Adjust the format specifier '%f' as needed for your data)
    for row = 1:size(data, 1)
        fprintf(fileID, '%d\n', data(row, :)); % Example for writing numeric data
    end

    % Close the file
    fclose(fileID);

end