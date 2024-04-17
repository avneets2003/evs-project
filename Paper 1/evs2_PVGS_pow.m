% Constants for the PV power generation system
rated_power = 1260; % Rated power output of the PV system (kW)
total_time = 100; % Total time in seconds
time_interval = 1; % Time interval in seconds

% Generate random power output data (for simulation purposes)
power_output = rated_power * (0.8 + 0.4 * rand(1, total_time)); % Random fluctuation between 80% and 120% of rated power

% Plot power vs time
time = 0:time_interval:total_time-time_interval;
plot(time, power_output, 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('Power (kW)');
title('PV Power Generation Profile at Zhangbei');
xlim([0 total_time]);
ylim([0 rated_power*1.2]); % Adjust ylim for better visualization
grid on;
