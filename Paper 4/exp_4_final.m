close all;
clc;
clear;

% Generate random load power profile with fluctuations
mean_load_power = 50; % Mean load power (kW)
fluctuation_amplitude = 10; % Amplitude of fluctuations (kW)
noise_level = 15; % Noise level to add randomness (kW)

time = 0:1:50; % Time vector

% Generate random fluctuations
fluctuations = fluctuation_amplitude * sin(2*pi*0.01*time); 

% Add noise to the fluctuations
noise = noise_level * randn(size(time));
fluctuations = fluctuations + noise;
% Generate load power profile
load_power_profile = mean_load_power + fluctuations;

% Define fuzzy logic controller parameters
threshold = 3; 
% Apply fuzzy logic controller to smooth the load power profile
for i = 2:length(load_power_profile)
    if abs(load_power_profile(i) - load_power_profile(i-1)) > threshold
        % If the difference between consecutive samples exceeds the threshold, smooth the value
        smoothed_load_power_profile(i) = (load_power_profile(i) + load_power_profile(i-1)) / 2;
    else
        smoothed_load_power_profile(i) = load_power_profile(i);
    end
end

% Define linguistic variables for rate of change
change_low = [0 0 5]; 
change_medium = [3 5 7]; 
change_high = [5 10 10]; 

% Define membership functions for rate of change
change_low_mf = trimf(time(2:end), change_low);
change_medium_mf = trimf(time(2:end), change_medium);
change_high_mf = trimf(time(2:end), change_high);

% Apply fuzzification
change = abs(diff(load_power_profile));
change_mf = zeros(size(time(2:end)));
for i = 1:length(change)
    if change(i) <= change_low(3)
        change_mf(i) = change_low_mf(i);
    elseif change(i) <= change_medium(3)
        change_mf(i) = change_medium_mf(i);
    else
        change_mf(i) = change_high_mf(i);
    end
end

% Define fuzzy rules
rule_low = change_low_mf;
rule_medium = change_medium_mf;
rule_high = change_high_mf;

% Combine rules
output = max(rule_low, max(rule_medium, rule_high));

% Defuzzification
output_crisp = sum(output.*time(2:end))/sum(output);

% Plot original, smoothed, and fuzzy smoothed load power profiles
figure;
hold on;
plot(time, load_power_profile, 'b', 'LineWidth', 1.5);
plot(time, smoothed_load_power_profile, 'r', 'LineWidth', 1.5);
title('Original Load Power Profile');
legend('Without Smoothing','With Smoothing')
xlabel('Time ');
ylabel('Load Power (kW)');
grid on;
hold off;

% Calculate standard deviation using built-in functions
std_dev_original = std(load_power_profile);
std_dev_smoothed = std(smoothed_load_power_profile);

fprintf('Standard Deviation of Original Load Power Profile: %.2f kW\n', std_dev_original);
fprintf('Standard Deviation of Smoothed Load Power Profile: %.2f kW\n', std_dev_smoothed);