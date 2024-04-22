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

% Define fuzzy logic membership functions
small_diff = @(x) max(0, min(1, (threshold - x) / threshold));
large_diff = @(x) max(0, min(1, x / threshold));

% Apply fuzzy logic controller to smooth the load power profile
for i = 2:length(load_power_profile)
    diff = abs(load_power_profile(i) - load_power_profile(i-1));
    % Calculate membership degrees
    small_diff_degree = small_diff(diff);
    large_diff_degree = large_diff(diff);
    % Defuzzify to get smoothed value
    smoothed_load_power_profile(i) = small_diff_degree * load_power_profile(i) + large_diff_degree * (load_power_profile(i) + load_power_profile(i-1)) / 2;
end


% Plot original, smoothed, and fuzzy smoothed load power profiles
figure;
hold on;
plot(time, load_power_profile, 'b', 'LineWidth', 1.5);
plot(time, smoothed_load_power_profile, 'r', 'LineWidth', 1.5);
title('WPGS output with and without FLC');
legend('Without Smoothing','With Smoothing')
xlabel('Time');
ylabel('Wind Power Output (kW)');
grid on;
hold off;

% Calculate standard deviation using built-in functions
std_dev_original = std(load_power_profile);
std_dev_smoothed = std(smoothed_load_power_profile);

fprintf('Standard Deviation of Original Load Power Profile: %.2f kW\n', std_dev_original);
fprintf('Standard Deviation of Smoothed Load Power Profile: %.2f kW\n', std_dev_smoothed);
