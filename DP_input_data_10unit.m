% Input Data for Dynamic Programming based Unit Commitment
% 10-Unit System from Abdelaziz et al.
%
%-----------------------------------------------------------------------
% Data from: 
% A.Y.Abdelaziz, M.Z.Kamh, S.F.Mekhamer, M.A.L.Badr: "An Augmented Hopfield Neural Network for
% Optimal Thermal Unit Commitment", International Journal of Power System Optimization, 
% January-June 2010, Volume 2, No. 1, pp. 37-49
% 
% PARAMETERS setting:
MIN_UP_DOWN_TIME_FLAG       = 1;        % take minimum up and down times into account (1) or not (0)
RAMP_UP_DOWN_FLAG           = 0;        % take ramp    up and down rates into account (1) or not (0)
N_PRED                      = 1;        % number of predecesors to be searched (N_PRED >= 1)
COMPLETE_ENUMERATION_FLAG   = 0;        % 1 - complete enumeration, 0 - priority list
DETAIL_PRINT_FLAG           = 0;        % detailed results printing: 0 - no, 1 - yes
DISPATCH_METHOD             = 1;        % 1 - quadprog, 2 - linprog, 3 - quick dispatch
RESERVE_FLAG                = 1;        % take spinning reserve in calculation (1) or not (0)
START_UP_COST_METHOD        = 1;        % 1-cold start-up (const), 2-cold/hot start-up, 3-exponential start-up
%-----------------------------------------------------------------------
% 10-Unit System from Abdelaziz et al. with derived linear cost coefficients
% 
% IMPORTANT NOTE: Linear coefficients (Inc_heat_rate, No_load_cost, Fuel_cost) were derived
% from the original quadratic coefficients using the following methodology:
% 
% Derivation approach:
%   1. No_load_cost = coef_a (constant term in quadratic cost function)
%   2. Fuel_cost = 2.0 £/MBTU (standard value used in industry)
%   3. Linear cost at midpoint: b_mid = coef_b + 2 * coef_c * P_mid
%   4. Inc_heat_rate = b_mid * 1000 / Fuel_cost  (BTU/kWh)
% 
% This derivation enables compatibility with all three dispatch methods (QUADPROG, LINPROG,
% Quick Dispatch) while preserving the economic characteristics of the original system.
%
% Unit_no.  Pmin   Pmax  Inc.heat_rate  No_load_cost  Start_cost_cold  Fuel_cost  Min_up_time  Min_down_time In.status   Start_cost_hot     Cold_start_[h]    Ramp-up      Ramp-down      coef_a      coef_b        coef_c       shut_down_cost      TAU
%           [MW]   [MW]   [BTU/kWh]*     [£/h]*        [£]            [£/MBTU]*     [h]           [h]          [h]         [£]                [h]            [MW/h]         [MW/h]        [£]        [£/MWh]      [£/MWh^2]          [£]            [h]
%                  (* = derived value)
gen_data = [...                                                                                                                                                                                                                                       
     1      30.0  100.0      4584.95        820.00           2050         2.00	        5           4          -10           NaN                NaN             NaN           NaN           820         9.023       0.00113             0            NaN 
     2     130.0  400.0      4251.00        400.00           1460         2.00	        3           2           10           NaN                NaN             NaN           NaN           400         7.654       0.00160             0            NaN 
     3     165.0  600.0      4938.27        600.00           2100         2.00	        2           4          -10           NaN                NaN             NaN           NaN           600         8.752       0.00147             0            NaN 
     4     130.0  420.0      4628.00        420.00           1480         2.00	        1           3          -10           NaN                NaN             NaN           NaN           420         8.431       0.00150             0            NaN 
     5     225.0  700.0      5693.75        540.00           2100         2.00	        4           5          -10           NaN                NaN             NaN           NaN           540         9.223       0.00234             0            NaN 
     6      50.0  200.0      4170.75        175.00           1360         2.00	        2           2           10           NaN                NaN             NaN           NaN           175         7.054       0.00515             0            NaN 
     7     250.0  750.0      5215.50        600.00           2300         2.00	        3           4          -10           NaN                NaN             NaN           NaN           600         9.121       0.00131             0            NaN 
     8     110.0  375.0      4295.68        400.00           1370         2.00	        1           3           10           NaN                NaN             NaN           NaN           400         7.762       0.00171             0            NaN 
     9     275.0  850.0      4801.00        725.00           2200         2.00	        4           3          -10           NaN                NaN             NaN           NaN           725         8.162       0.00128             0            NaN 
    10      75.0  250.0      4809.00        200.00           1180         2.00	        2           1           10           NaN                NaN             NaN           NaN           200         8.149       0.00452             0            NaN 
];

DEMAND = [1025;1000;900;850;1025;1400;1970;2400;2850;3150;3300;3400;3275;2950;2700;2550;2725;3200;3300;2900;2125;1650;1300;1150];
RES_UP = [85;85;65;55;85;110;165;190;210;230;250;275;240;210;200;195;200;220;250;210;170;130;100;90];
RES_DN = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
