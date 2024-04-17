% Constants
total_time = 24 * 3600; % Total time in seconds (one day)
time_interval = 1; % Time interval in seconds
vertical_increase = 15; % Vertical increase in SOC (%)
vertical_time = 6 * 3600; % Vertical increase period in seconds (6 hours)
bess_count = 5; % Number of BESS units
initial_soc = [90, 70, 50, 30, 10]; % Initial SOC for each BESS unit

% Initialize SOC for each BESS
soc_profiles = zeros(total_time, bess_count);

% Simulate SOC profiles for each BESS
for i = 1:bess_count
    soc = initial_soc(i); % Initial SOC for the current BESS unit
    
    % Constant initial period
    soc_profiles(1:vertical_time, i) = soc;
    
    % Vertical increase period
    vertical_steps = vertical_time / time_interval;
    for t = 1:vertical_steps
        soc_profiles(t, i) = soc;
    end
    
    % Constant final period
    soc_profiles(vertical_steps+1:end, i) = soc + vertical_increase;
end

% Plot SOC profiles for each BESS unit on the same graph
figure;
hold on;
for i = 1:bess_count
    plot(1:total_time, soc_profiles(:, i), 'LineWidth', 1.5);
end
hold off;
xlabel('Time (s)');
ylabel('State of Charge (%)');
title('State of Charge Profiles for BESS Units - Case C');
legend('BESS 1', 'BESS 2', 'BESS 3', 'BESS 4', 'BESS 5', 'Location', 'best');
