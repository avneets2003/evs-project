% Constants
total_time = 100; % Total time in seconds
time_interval = 1; % Time interval in seconds
p_fluctuation_limit = 0.1 * 15 * 60; % Power fluctuation rate limit: 10% per 15 min

% Generate random power profiles for WP, PV, BESS
p_wp = 1.5 + 0.5 * randn(1, total_time); % Random wind power profile
p_pv = 1.2 + 0.3 * randn(1, total_time); % Random PV power profile
p_bess = 1 + 0.3 * randn(1, total_time); % Random BESS power profile
p_wppv = p_wp + p_pv; % Combined wind and PV power profile

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
    delta_p = p_wp(t) - p_smooth_method2(t-1);
    if abs(delta_p) <= p_fluctuation_limit
        p_smooth_method2(t) = p_wp(t);
    else
        p_smooth_method2(t) = p_smooth_method2(t-1) + sign(delta_p) * p_fluctuation_limit;
    end
end

% Plotting
figure;

% Plot Method 1
plot(1:total_time, p_bess, 'r', 1:total_time, p_pv, 'g', 1:total_time, p_smooth_method1, 'm', 1:total_time, p_wppv + 0.05, 'c', 1:total_time, p_wp, 'b', 1:total_time, p_smooth_method1 + 0.1, 'k', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Power (kW)');
title('Power Profiles - Method 1');
legend('BESS', 'PV', 'Smoothed Power', 'WP+PV', 'WP', 'Smoothed WP');
std_dev_1 = std(p_wp)

% Plot Method 2
figure;
plot(1:total_time, p_bess, 'r', 1:total_time, p_pv, 'g', 1:total_time, p_smooth_method2, 'm', 1:total_time, p_wppv + 0.05, 'c', 1:total_time, p_wp, 'b', 1:total_time, p_smooth_method2 + 0.1, 'k', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Power (kW)');
title('Power Profiles - Method 2');
legend('BESS', 'PV', 'Smoothed Power', 'WP+PV', 'WP', 'Smoothed WP');
std_dev_2 = std(p_wp)
