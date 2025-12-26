% Script to run 24-hour 10-unit system with all dispatch methods

fprintf('\n======================================================================\n');
fprintf('TASK 2B: Testing 10-Unit System with 24-Hour Demand\n');
fprintf('======================================================================\n\n');

% Copy 10-unit input data to main file
system('cp DP_input_data_10unit.m DP_input_data.m');

% Test Method 1: QUADPROG
fprintf('\n--- Method 1: QUADPROG (10-unit, 24 hours) ---\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 1;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 1: %s\n', ME.message);
end

% Test Method 2: LINPROG
fprintf('\n--- Method 2: LINPROG (10-unit, 24 hours) ---\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 2;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 2: %s\n', ME.message);
end

% Test Method 3: Quick Dispatch
fprintf('\n--- Method 3: Quick Dispatch (10-unit, 24 hours) ---\n');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 3;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');
try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR in Method 3: %s\n', ME.message);
end

fprintf('\n======================================================================\n');
fprintf('TASK 2B COMPLETED\n');
fprintf('======================================================================\n');

% Restore 4-unit 24-hour data
system('cp DP_input_data_8h.m temp_restore.m');
system('sed -i "s/DEMAND = \[450;530;600;540;400;280;290;500\];/DEMAND = [450;530;600;540;400;280;290;500;550;620;650;600;520;450;380;320;300;280;350;420;480;530;570;500];/" temp_restore.m');
system('cp temp_restore.m DP_input_data.m');
