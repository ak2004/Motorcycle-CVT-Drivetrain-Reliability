%% Motorcycle CVT Drivetrain - System Reliability
% MEM 361 Engineering Reliability
%
% Calculates total drivetrain reliability using the
% series-parallel Reliability Block Diagram.

clear;
clc;
close all;

%% Mission Time
t = 8760;      % One year [hr]

%% Component Parameters
beta_clutch = 1.4;
eta_clutch  = 11*8760;

beta_belt = 1.2;
eta_belt  = 3*8760;

beta_gearbox = 2.0;
eta_gearbox  = 9*8760;

beta_bearing = 1.3;
eta_bearing  = 5*8760;

beta_seal = 1.4;
eta_seal  = 3*8760;

lambda_sheave = 1.5e-6;

%% Component Reliability
R_clutch_single = exp(-(t/eta_clutch)^beta_clutch);
R_clutch = 1 - (1-R_clutch_single)^2;

R_belt = exp(-(t/eta_belt)^beta_belt);
R_input = exp(-lambda_sheave*t);
R_output = exp(-lambda_sheave*t);
R_gearbox = exp(-(t/eta_gearbox)^beta_gearbox);
R_bearing = exp(-(t/eta_bearing)^beta_bearing);
R_seal = exp(-(t/eta_seal)^beta_seal);

%% Series-Parallel System Reliability
R_system = ...
    R_clutch * ...
    R_input * ...
    R_belt * ...
    R_output * ...
    R_gearbox * ...
    R_bearing * ...
    R_seal;

%% Results
fprintf('\nMOTORCYCLE CVT SYSTEM RELIABILITY\n');
fprintf('---------------------------------\n');

fprintf('Clutch Assembly: %.4f\n',R_clutch);
fprintf('Input Sheave:    %.4f\n',R_input);
fprintf('Drive Belt:      %.4f\n',R_belt);
fprintf('Output Sheave:   %.4f\n',R_output);
fprintf('Gearbox:         %.4f\n',R_gearbox);
fprintf('Bearing:         %.4f\n',R_bearing);
fprintf('Oil Seal:        %.4f\n\n',R_seal);

fprintf('ONE-YEAR SYSTEM RELIABILITY = %.4f\n',R_system);
fprintf('ONE-YEAR SYSTEM RELIABILITY = %.2f %%\n',100*R_system);
