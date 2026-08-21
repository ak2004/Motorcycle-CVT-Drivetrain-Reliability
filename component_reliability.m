%% Motorcycle CVT Drivetrain - Component Reliability
% MEM 361 Engineering Reliability
%
% Calculates the one-year reliability of the major drivetrain
% components using Weibull and exponential reliability models.

clear;
clc;
close all;

%% Mission Time
t = 8760;      % One year of continuous operation [hr]

%% Weibull Component Parameters
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

%% Sheave Failure Rates
lambda_input  = 1.5e-6;     % failures/hr
lambda_output = 1.5e-6;     % failures/hr

%% Weibull Reliability
R_clutch_single = exp(-(t/eta_clutch)^beta_clutch);
R_belt = exp(-(t/eta_belt)^beta_belt);
R_gearbox = exp(-(t/eta_gearbox)^beta_gearbox);
R_bearing = exp(-(t/eta_bearing)^beta_bearing);
R_seal = exp(-(t/eta_seal)^beta_seal);

%% Parallel Clutch Reliability
R_clutch = 1 - (1 - R_clutch_single)^2;

%% Exponential Sheave Reliability
R_input  = exp(-lambda_input*t);
R_output = exp(-lambda_output*t);

%% Display Results
fprintf('\nMOTORCYCLE CVT COMPONENT RELIABILITY\n');
fprintf('------------------------------------\n');
fprintf('Mission Time: %.0f hr (1 year)\n\n',t);

fprintf('Clutch Plate (single): %.4f\n',R_clutch_single);
fprintf('Clutch Assembly:       %.4f\n',R_clutch);
fprintf('Input Sheave:          %.4f\n',R_input);
fprintf('Drive Belt:            %.4f\n',R_belt);
fprintf('Output Sheave:         %.4f\n',R_output);
fprintf('Gearbox:               %.4f\n',R_gearbox);
fprintf('Bearing:               %.4f\n',R_bearing);
fprintf('Oil Seal:              %.4f\n',R_seal);
