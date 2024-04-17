% Constants
total_time = 100; % Total time in seconds
time_interval = 1; % Time interval in seconds
p_fluctuation_limit = 0.1 * 15 * 60; % Power fluctuation rate limit: 10% per 15 min

% Generate random power profiles for WP
p_wp = 1000 + 500 * randn(1, total_time); % Random wind power profile

% Method 1: Smoothing with first-order filter
tau = 600; % Time constant for first-order filter
p_smooth_method1 = zeros(1, total_time);
p_smooth_method1(1) = p_wp(1); % Initial smoothed power equals wind power
for t = 2:total_time
    delta_p = p_wp(t) - p_smooth_method1(t-1);
    if abs(delta_p) <= p_fluctuation_limit
        p_smooth_method1(t) = p_smooth_method1(t-1) + delta_p;
    else
        p_smooth_method1(t) = p_smooth_method1(t-1) + sign(delta_p) * p_fluctuation_limit;
    end
end

% Method 2: Smoothing without filter
p_smooth_method2 = zeros(1, total_time);
p_smooth_method2(1) = p_wp(1); % Initial smoothed power equals wind power
for t = 2:total_time
    % Introduce variation in power profile for Method 2
    p_smooth_method2(t) = p_smooth_method1(t) + 50 * randn; % Add random noise
    % Check if the variation exceeds the fluctuation limit
    if p_smooth_method2(t) - p_smooth_method2(t-1) > p_fluctuation_limit
        p_smooth_method2(t) = p_smooth_method2(t-1) + p_fluctuation_limit;
    elseif p_smooth_method2(t-1) - p_smooth_method2(t) > p_fluctuation_limit
        p_smooth_method2(t) = p_smooth_method2(t-1) - p_fluctuation_limit;
    end
end

% Calculate power fluctuation rate profile with BESS for Method 1
fluctuation_rate_method1_bess = diff(p_smooth_method1) / time_interval;

% Calculate power fluctuation rate profile without BESS for Method 1
fluctuation_rate_method1_no_bess = diff(p_wp) / time_interval;

% Calculate power fluctuation rate profile with BESS for Method 2
fluctuation_rate_method2_bess = diff(p_smooth_method2) / time_interval;

% Calculate power fluctuation rate profile without BESS for Method 2
fluctuation_rate_method2_no_bess = diff(p_wp) / time_interval;

% Plotting for Method 1
figure;

% Plot with and without BESS in the same graph for Method 1
plot(1:total_time-1, fluctuation_rate_method1_bess, 'b', 'LineWidth', 1.5);
hold on;
plot(1:total_time-1, fluctuation_rate_method1_no_bess, 'r--', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Power Fluctuation Rate (kW/s)');
title('Power Fluctuation Rate Profile - Method 1');
legend('With BESS', 'Without BESS');

% Plotting for Method 2
figure;

% Plot with and without BESS in the same graph for Method 2
plot(1:total_time-1, fluctuation_rate_method2_bess, 'b', 'LineWidth', 1.5);
hold on;
plot(1:total_time-1, fluctuation_rate_method2_no_bess, 'r--', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Power Fluctuation Rate (kW/s)');
title('Power Fluctuation Rate Profile - Method 2');
legend('With BESS', 'Without BESS');

% Calculate mean and standard deviation for Method 1 with BESS
mean_method1_bess = mean(fluctuation_rate_method1_bess);
std_dev_method1_bess = std(fluctuation_rate_method1_bess);

% Calculate mean and standard deviation for Method 1 without BESS
mean_method1_no_bess = mean(fluctuation_rate_method1_no_bess);
std_dev_method1_no_bess = std(fluctuation_rate_method1_no_bess);

% Calculate mean and standard deviation for Method 2 with BESS
mean_method2_bess = mean(fluctuation_rate_method2_bess);
std_dev_method2_bess = std(fluctuation_rate_method2_bess);

% Calculate mean and standard deviation for Method 2 without BESS
mean_method2_no_bess = mean(fluctuation_rate_method2_no_bess);
std_dev_method2_no_bess = std(fluctuation_rate_method2_no_bess);

% Display the results
disp('Method 1 with BESS:');
disp(['Mean: ', num2str(mean_method1_bess), ' kW/s']);
disp(['Standard Deviation: ', num2str(std_dev_method1_bess), ' kW/s']);

disp('Method 1 without BESS:');
disp(['Mean: ', num2str(mean_method1_no_bess), ' kW/s']);
disp(['Standard Deviation: ', num2str(std_dev_method1_no_bess), ' kW/s']);

disp('Method 2 with BESS:');
disp(['Mean: ', num2str(mean_method2_bess), ' kW/s']);
disp(['Standard Deviation: ', num2str(std_dev_method2_bess), ' kW/s']);

disp('Method 2 without BESS:');
disp(['Mean: ', num2str(mean_method2_no_bess), ' kW/s']);
disp(['Standard Deviation: ', num2str(std_dev_method2_no_bess), ' kW/s']);