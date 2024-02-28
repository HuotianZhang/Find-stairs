function [smoothedSignal, Positions, Values, Index] = Findstairs(InputData)
    % Example signal (Replace with your actual signal)
    % signal = [32000*rand(1,200) - 16000, 32000*rand(1,300) + 16000, 32000*rand(1,250) - 8000];
    % signal = signal + cumsum([0, diff(signal) > 500] - 0.5); % Adding artificial stairs for demonstration
    
    signal = InputData;
    
    % Smooth the signal
    windowSize = 3; % Adjust based on your signal's characteristics
    smoothedSignal = smoothdata(signal, 'movmean', windowSize);
    
    % Find significant changes
    diffSignal = [0; diff(smoothedSignal)]; % Prepend 0 to align with original signal length
    threshold = 20; % Set based on the minimum expected step change
    changeIndices = find(abs(diffSignal) < threshold);
    
    % Extract the stair values, considering the smoothing
    stairValues = smoothedSignal(changeIndices);
    
    % Optionally, refine stairValues to ensure uniqueness or further processing
    
    
    
    % Assuming 'signal' is your data vector
    
    % Initialize variables
    currentPlatformStartIndex = 1; % Start index of the current platform
    platformIndex = 0;
    platformPositions = [];
    platformValues = []; % To store average values of each platform
    i = 2; % Start from the second point
    
    while i <= length(stairValues)
        % Calculate the difference from the current point to the previous point
        currentDiff = abs(stairValues(i) - stairValues(i-1));
        
        % Check if the current difference exceeds the threshold
        if currentDiff >= 200 || i == length(stairValues)
            % If it does, or we are at the end of the signal, process the current platform
            if i == length(stairValues) && currentDiff < 200
                i = i + 1; % Include the last point in the current platform
            end
            % Calculate the average for the current platform
            platformAverage = mean(stairValues(currentPlatformStartIndex:i-1));
            platformValues = [platformValues; platformAverage]; % Append the average
            platformPositionAverage = mean(changeIndices(currentPlatformStartIndex:i-1));
            platformPositions = [platformPositions; platformPositionAverage];
    
            % Update the start index for the next platform
            currentPlatformStartIndex = i;
            platformIndex = platformIndex + 1;
        end
        
        % Move to the next point
        i = i + 1;
    end
    Positions = platformPositions;
    Values = platformValues;
    Index = platformIndex;

    % platformValues now contains the average values of each continuous platform
    
    % Plot the original and smoothed signals for visualization
    % figure;
    % plot(signal, 'b-', 'DisplayName', 'Original Signal');
    % hold on;
    % plot(smoothedSignal, 'r-', 'DisplayName', 'Smoothed Signal');
    % legend('show');
    % 
    % % Highlight changes
    % plot(platformPositions, platformValues, 'kx', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Stair Changes');
    % title('Signal with Detected Stairs');
    % xlabel('Data Point');
    % ylabel('Signal Value');
end