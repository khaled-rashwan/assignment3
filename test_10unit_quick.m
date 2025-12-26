% Quick test of 10-unit system with Quick Dispatch

fprintf('\nQuick Test: 10-Unit System with Quick Dispatch\n');
fprintf('================================================\n\n');

system('cp DP_input_data_10unit.m DP_input_data.m');
system('sed -i "s/DISPATCH_METHOD.*=.*/DISPATCH_METHOD             = 3;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch/" DP_input_data.m');

try
    DP_v8();
    fprintf('\n');
catch ME
    fprintf('ERROR: %s\n', ME.message);
end
