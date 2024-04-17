% Constants for Sinovel SL3000/113 wind turbine
rated_power = 2500; % Rated power output of the wind turbine (kW)
cut_in_speed = 3; % Cut-in wind speed (m/s)
cut_out_speed = 25; % Cut-out wind speed (m/s)

% Constants for simulation
total_time = 100; % Total time in seconds
time_interval = 1; % Time interval in seconds

% Generate random wind speed data (for simulation purposes)
wind_speed = 8 + 2 * randn(1, total_time); % Mean wind speed of 8 m/s with standard deviation of 2 m/s

% Calculate power output based on wind speed (using Sinovel SL3000/113 turbine characteristics)
power_output = zeros(1, total_time);
for t = 1:total_time
    if wind_speed(t) < cut_in_speed % Below cut-in wind speed
        power_output(t) = 0;
    elseif wind_speed(t) >= cut_out_speed % Above cut-out wind speed
        power_output(t) = 0;
    else % Linear interpolation between cut-in and cut-out wind speed
        power_output(t) = rated_power * ((wind_speed(t) - cut_in_speed) / (cut_out_speed - cut_in_speed));
    end
end

% Plot power vs time
time = 0:time_interval:total_time-time_interval;
plot(time, power_output, 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('Power (kW)');
title('Wind Power Generation Profile of Sinovel SL3000/113 at Zhangbei');
xlim([0 total_time]);
ylim([0 rated_power]);
grid on;
