% Wind Power Generation System Simulation

% Parameters
rated_power = 100; % kW
cut_in_speed = 3; % m/s
cut_out_speed = 25; % m/s
rated_speed = 15; % m/s
air_density = 1.225; % kg/m^3
blade_radius = 20; % meters
power_curve_slope = 0.4; % slope of power curve

% Simulation time
sim_time = 24; % hours
time_step = 1; % hour

% Wind speed profile (example, can be replaced with actual data)
wind_speed = rand(1, sim_time+1) * 30; % random wind speed between 0 and 30 m/s
wind_speed(1) = 0; % Ensure the first element is 0 to align with time

% Initialize variables
time = 0:time_step:sim_time;
power_generated = zeros(1, length(time));

% Simulation loop
for t = 1:length(time)
    % Calculate power generated based on wind speed
    if wind_speed(t) < cut_in_speed || wind_speed(t) > cut_out_speed
        power_generated(t) = 0;
    elseif wind_speed(t) >= cut_in_speed && wind_speed(t) <= rated_speed
        power_generated(t) = (wind_speed(t)^3) * pi * (blade_radius^2) * air_density * power_curve_slope;
    elseif wind_speed(t) > rated_speed && wind_speed(t) <= cut_out_speed
        power_generated(t) = rated_power;
    end
end

% Plot results
figure;
plot(time, power_generated, 'g', 'LineWidth', 2);
xlabel('Time (hours)');
ylabel('Power Generated (kW)');
title('Wind Power Generation Profile');
