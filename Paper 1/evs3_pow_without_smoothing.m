
total_time = 30; % Total time in seconds
time_interval = 1; % Time interval in seconds

% Generate random power profiles for WP
p_wp = 1.5 + 0.5 * randn(1, total_time); % Random wind power profile

% Plotting for Method 1
figure;

% Plot with and without BESS in the same graph for Method 1
plot(1:total_time, p_wp, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Power(kW)');
title('Power without smoothing');

std_dev= std(p_wp)