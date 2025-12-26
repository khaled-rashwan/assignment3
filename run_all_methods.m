% Script to run all three dispatch methods and collect results
%
% NOTE: This script uses shell 'sed' commands for simplicity in changing configuration.
% For production use, consider implementing a MATLAB-native configuration function
% to avoid platform dependencies and improve robustness.

fprintf('\n======================================================================\n');
fprintf('TASK 1: Testing 4-Unit System with 8-Hour Demand\n');
fprintf('======================================================================\n\n');

% Test Method 1: QUADPROG
fprintf('\n--- Method 1: QUADPROG ---\n');
fprintf('Modifying DISPATCH_METHOD to 1...\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 1;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 1: %s\n', ME.message);
end

% Test Method 2: LINPROG  
fprintf('\n--- Method 2: LINPROG ---\n');
fprintf('Modifying DISPATCH_METHOD to 2...\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 2;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 2: %s\n', ME.message);
end

% Test Method 3: Quick Dispatch
fprintf('\n--- Method 3: Quick Dispatch ---\n');
fprintf('Modifying DISPATCH_METHOD to 3...\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 3;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 3: %s\n', ME.message);
end

fprintf('\n======================================================================\n');
fprintf('ALL TESTS COMPLETED\n');
fprintf('======================================================================\n');
