%% Weibull Failure Distribution Analysis
% Motorcycle CVT Drivetrain Reliability

clear;
clc;
close all;

%% Component Data
% {Name, Beta, Eta [hr]}
components = {
    'Drive Belt',   1.2, 3*8760;
    'Bearings',     1.3, 5*8760;
    'Oil Seals',    1.4, 3*8760;
    'Gearbox',      2.0, 9*8760;
    'Clutch Plate', 1.4, 11*8760;
};

%% Common Time Range
max_eta = max(cell2mat(components(:,3)));
t = linspace(100,3*max_eta,3000);

%% Generate Weibull PDFs
figure;
hold on;

for i = 1:size(components,1)

    name = components{i,1};
    beta = components{i,2};
    eta  = components{i,3};

    pdf = (beta/eta) .* ...
          (t/eta).^(beta-1) .* ...
          exp(-(t/eta).^beta);

    plot(t/8760,pdf,...
        'LineWidth',2.2,...
        'DisplayName',name);

end

hold off;

%% Formatting
xlabel('Time (years)');
ylabel('Probability Density f(t)');
title('Weibull Failure Distributions of CVT Components');
legend('Location','best');
grid on;
box on;
xlim([0 3*max_eta/8760]);

%% Export
exportgraphics(gcf,...
    'weibull_component_comparison.png',...
    'Resolution',300);
