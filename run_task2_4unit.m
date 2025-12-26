% Script to run 24-hour 4-unit system with all dispatch methods

fprintf('\n======================================================================\n');
fprintf('TASK 2A: Testing 4-Unit System with 24-Hour Demand\n');
fprintf('======================================================================\n\n');

% Test Method 1: QUADPROG
fprintf('\n--- Method 1: QUADPROG (24 hours) ---\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 1;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 1: %s\n', ME.message);
end

% Test Method 2: LINPROG
fprintf('\n--- Method 2: LINPROG (24 hours) ---\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 2;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 2: %s\n', ME.message);
end

% Test Method 3: Quick Dispatch
fprintf('\n--- Method 3: Quick Dispatch (24 hours) ---\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 3;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 3: %s\n', ME.message);
end

fprintf('\n======================================================================\n');
fprintf('TASK 2A COMPLETED\n');
fprintf('======================================================================\n');
