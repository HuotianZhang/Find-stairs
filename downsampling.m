function result = downsampling(currentFilePath)
    fileID = fopen(currentFilePath, 'r');
    downsamplingFactor = 1000;
    chunkSize = 10000 * downsamplingFactor; % Adjust chunk size based on available memory
    downsampledData = [];
    
    while ~feof(fileID)
        % Read a chunk of the file
        C = textscan(fileID, '%f', chunkSize, 'Delimiter', '\n');
        dataChunk = C{1};
        
        % Downsample the chunk and append to the downsampledData array
        downsampledDataChunk = dataChunk(1:downsamplingFactor:end);
        downsampledData = [downsampledData; downsampledDataChunk];
    end
    fclose(fileID);
    result = downsampledData;
end