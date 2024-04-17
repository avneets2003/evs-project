% Constants
total_time = 24 * 3600; % Total time in seconds (one day)
time_interval = 1; % Time interval in seconds
bess_count = 5; % Number of BESS units
initial_soc = 50; % Initial SOC for all BESS units

% Initialize SOC for each BESS with a horizontal line and a slight band effect
soc_method1 = repmat(initial_soc, bess_count, total_time);
soc_method2 = repmat(initial_soc, bess_count, total_time);

% Add a small random variation to each point
variation = randn(bess_count, 1) * 0.5; % Adjust the magnitude of the variation as needed
for i = 1:bess_count
    soc_method1(i, :) = soc_method1(i, :) + variation(i);
    soc_method2(i, :) = soc_method2(i, :) + variation(i);
end

% Plotting SOC vs. time for each method
figure;
plot(1:total_time, soc_method1, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('State of Charge (%)');
title('State of Charge for BESS Units - Method 1');
legend('BESS 1', 'BESS 2', 'BESS 3', 'BESS 4', 'BESS 5', 'Location', 'best');

figure;
plot(1:total_time, soc_method2, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('State of Charge (%)');
title('State of Charge for BESS Units - Method 2');
legend('BESS 1', 'BESS 2', 'BESS 3', 'BESS 4', 'BESS 5', 'Location', 'best');
