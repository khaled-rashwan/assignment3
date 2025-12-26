% Test script to run DP_v8 and capture results
try
    % Suppress unnecessary output
    close all;
    
    % Run the main function
    DP_v8();
    
    fprintf('\n=== TEST COMPLETED SUCCESSFULLY ===\n');
catch ME
    fprintf('\n=== ERROR OCCURRED ===\n');
    fprintf('Error: %s\n', ME.message);
    fprintf('Stack:\n');
    for i = 1:length(ME.stack)
        fprintf('  %s (line %d)\n', ME.stack(i).name, ME.stack(i).line);
    end
end
