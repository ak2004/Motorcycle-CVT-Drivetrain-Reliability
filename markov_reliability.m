%% Three-State Markov Reliability Model
% Motorcycle CVT Drivetrain
%
% States:
% State 0 = Fully Operational
% State 1 = Degraded (one clutch plate failed)
% State F = Failed

clear;
clc;
close all;

%% Failure Rates
lambda_c = 3.95e-6;      % Single clutch plate [hr^-1]
lambda_s = 7.358e-5;     % Combined series components [hr^-1]

%% Time
t = linspace(0,8760,1000);

%% State Probabilities
P0 = exp(-(2*lambda_c + lambda_s).*t);

P1 = 2 .* exp(-lambda_s.*t) .* ...
     (exp(-lambda_c.*t) - exp(-2*lambda_c.*t));

PF = 1 - P0 - P1;

%% System Reliability
R = P0 + P1;

%% One-Year Results
P0_1yr = P0(end);
P1_1yr = P1(end);
PF_1yr = PF(end);
R_1yr  = R(end);

fprintf('\nTHREE-STATE MARKOV MODEL\n');
fprintf('------------------------\n');

fprintf('Fully Operational: %.4f (%.2f%%)\n',P0_1yr,100*P0_1yr);
fprintf('Degraded:          %.4f (%.2f%%)\n',P1_1yr,100*P1_1yr);
fprintf('Failed:            %.4f (%.2f%%)\n',PF_1yr,100*PF_1yr);

fprintf('\nOne-Year Reliability: %.4f (%.2f%%)\n',R_1yr,100*R_1yr);

%% Plot State Probabilities
figure;

plot(t/8760,P0,'LineWidth',2);
hold on;
plot(t/8760,P1,'LineWidth',2);
plot(t/8760,PF,'LineWidth',2);
plot(t/8760,R,'--','LineWidth',2.2);
hold off;

xlabel('Time (years)');
ylabel('Probability');
title('Motorcycle CVT Markov Reliability Model');

legend(...
    'Fully Operational',...
    'Degraded',...
    'Failed',...
    'System Reliability',...
    'Location','best');

grid on;
box on;
ylim([0 1]);

%% Export Figure
exportgraphics(gcf,...
    'markov_state_probabilities.png',...
    'Resolution',300);
