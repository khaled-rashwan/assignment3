% Script to calculate quadratic cost coefficients from linear cost data
% For the 4-unit Wood and Wollenberg system

% Existing data from DP_input_data.m
% Unit_no.    Pmin   Pmax  Inc.heat_rate  No_load_cost  Fuel_cost
%             [MW]   [MW]    [BTU/kWh]        [£/h]     [£/MBTU]
gen_data_linear = [
      1        25     80      10440           213.00      2.00
      2        60    250       9000           585.62      2.00
      3        75    300       8730           684.74      2.00
      4        20     60      11900           252.00      2.00
];

GMIN = gen_data_linear(:, 1);
GMAX = gen_data_linear(:, 2);
GINC = gen_data_linear(:, 3);  % Incremental heat rate [BTU/kWh]
GNLC = gen_data_linear(:, 4);  % No load cost [£/h]
GFC = gen_data_linear(:, 5);   % Fuel cost [£/MBTU]

% The linear cost model is: Cost = GNLC + GFC * GINC * P / 1000
% where P is power in MW
% This simplifies to: Cost = GNLC + (GFC * GINC / 1000) * P
%
% For quadratic model: Cost = a + b*P + c*P^2
%
% We can match at two points: Pmin and Pmax
% And set a small quadratic coefficient to maintain convexity

fprintf('Calculating quadratic cost coefficients for 4-unit system:\n');
fprintf('===========================================================\n\n');

for i = 1:size(gen_data_linear, 1)
    % Linear cost coefficient (£/MWh)
    b_linear = GFC(i) * GINC(i) / 1000;
    
    % For quadratic approximation, we'll use:
    % coef_a = No load cost (£/h)
    % coef_b = Linear coefficient from incremental cost (£/MWh)
    % coef_c = Small quadratic term for convexity (£/MW²h)
    
    % Choose a small c to add slight convexity without drastically changing costs
    % Typically 0.001-0.01% of the linear coefficient
    coef_c = b_linear * 0.0001;  % Very small quadratic term
    
    % Adjust b to maintain similar cost at midpoint
    coef_b = b_linear;
    coef_a = GNLC(i);
    
    % Verify costs at Pmin, Pmid, and Pmax
    Pmid = (GMIN(i) + GMAX(i)) / 2;
    
    % Linear model costs
    cost_linear_min = GNLC(i) + b_linear * GMIN(i);
    cost_linear_mid = GNLC(i) + b_linear * Pmid;
    cost_linear_max = GNLC(i) + b_linear * GMAX(i);
    
    % Quadratic model costs
    cost_quad_min = coef_a + coef_b * GMIN(i) + coef_c * GMIN(i)^2;
    cost_quad_mid = coef_a + coef_b * Pmid + coef_c * Pmid^2;
    cost_quad_max = coef_a + coef_b * GMAX(i) + coef_c * GMAX(i)^2;
    
    fprintf('Unit %d:\n', i);
    fprintf('  Pmin = %.1f MW, Pmax = %.1f MW\n', GMIN(i), GMAX(i));
    fprintf('  coef_a = %.2f £/h\n', coef_a);
    fprintf('  coef_b = %.4f £/MWh\n', coef_b);
    fprintf('  coef_c = %.6f £/MW²h\n', coef_c);
    fprintf('  Cost comparison:\n');
    fprintf('    At Pmin: Linear = %.2f, Quadratic = %.2f\n', cost_linear_min, cost_quad_min);
    fprintf('    At Pmid: Linear = %.2f, Quadratic = %.2f\n', cost_linear_mid, cost_quad_mid);
    fprintf('    At Pmax: Linear = %.2f, Quadratic = %.2f\n\n', cost_linear_max, cost_quad_max);
end

fprintf('\nCoefficients to add to DP_input_data.m:\n');
fprintf('=========================================\n');
for i = 1:size(gen_data_linear, 1)
    b_linear = GFC(i) * GINC(i) / 1000;
    coef_c = b_linear * 0.0001;
    coef_b = b_linear;
    coef_a = GNLC(i);
    
    fprintf('Unit %d:  coef_a = %8.2f,  coef_b = %8.4f,  coef_c = %10.6f\n', ...
            i, coef_a, coef_b, coef_c);
end
