clear all; close all; clc; set(0, 'defaultfigurecolor', [1 1 1]);

Re_i = [100]; % 750]; <-- uncommet for Re=750 (takes longer time)
for i = 1:length(Re_i)
    clearvars -except i Re_i         % Clear workspace from previous Re number
    Re = Re_i(i);                    % Index of Reynolds number
    main_Initialization;             % Script for initializing values and execution
    main_Boundary_Conditions;        % Script for applying boundary conditions
    main_Process_calculation;        % Script for the iterative computation process
    main_Visualization;              % Script for plotting the graphs
end

