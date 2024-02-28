data = readmatrix("\\ad.liu.se\home\huozh22\Downloads\DC_Calibrate_lean\DC_Calibrate_lean\downsampling\Sweep-20um+-200um_new_0_downsampling.txt");
[smoothedSignal, Positions, Values, Index] = Findstairs(data);
    
% Plot
plot(data, 'b-', 'DisplayName', 'Original Signal');
hold on;
plot(smoothedSignal, 'r-', 'DisplayName', 'Smoothed Signal');
legend('show');

% Highlight changes
plot(Positions, Values, 'kx', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Stair Changes');
title('Signal with Detected Stairs');
xlabel('Data Point');
ylabel('Signal Value');

