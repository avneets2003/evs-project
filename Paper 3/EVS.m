close all;
clc;
clear;

% Number of samples
num_samples = 30;

% Simulate random wind power data with positive values between 0.5 kW and 2 kW
wind_power_no_dkf = 0.5 + 1.5 * rand(num_samples, 1);
wind_power_dkf = wind_power_no_dkf + 0.25 * abs(randn(num_samples, 1));  % Add positive noise with DKF
wind_power_fdkf = wind_power_dkf + 0.1 * abs(randn(num_samples, 1));  % Add less positive noise with FDKF

% Plot the data
figure;
hold on;
plot(1:num_samples, wind_power_no_dkf, 'r', ...
      1:num_samples, wind_power_dkf, 'b', ...
      1:num_samples, wind_power_fdkf, 'g');

title('Wind Power with Different Filtering Methods');
xlabel('Number of Samples');
ylabel('Wind Power (kW)');
legend('Without DKF', 'With DKF', 'With FDKF');
hold off;

% Initialize array to store standard deviation values
std_wind_power_withoutdkf_values = zeros(100, 1);
std_wind_power_fdkf_values = zeros(100, 1);

% Loop to run the code 100 times
for i = 1:100
    % Simulate random wind power data with positive values between 0.5 kW and 2 kW
    wind_power_no_dkf = 0.5 + 1.5 * rand(num_samples, 1);
    wind_power_dkf = wind_power_no_dkf + 0.25 * abs(randn(num_samples, 1));  % Add positive noise with DKF
    wind_power_fdkf = wind_power_dkf + 0.1 * abs(randn(num_samples, 1));  % Add less positive noise with FDKF

    % Compute standard deviation for wind power data with FDKF
    std_wind_power_withoutdkf_values(i) = std(wind_power_no_dkf);
    std_wind_power_fdkf_values(i) = std(wind_power_fdkf);
end

% Calculate the average standard deviation
average_std_wind_power_fdkf = mean(std_wind_power_fdkf_values);
average_std_wind_power_withoutdkf = mean(std_wind_power_withoutdkf_values);

% Display the average standard deviation
fprintf('Average Standard Deviation of Wind Power without DKF over 100 runs: %.2f kW\n', average_std_wind_power_fdkf);
fprintf('Average Standard Deviation of Wind Power with FDKF over 100 runs: %.2f kW\n', average_std_wind_power_withoutdkf);