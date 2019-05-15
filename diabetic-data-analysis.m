rng('default') % For reproducibility

% pre-allocation
h_f = zeros(1, 10); % healthy-fasting
d_f = zeros(1, 10); % diabetic-fasting

h_notF = zeros(1, 10); % healthy-not-fasting
d_notF = zeros(1, 10); % diabetic-not-fasting

h_avg = zeros(1, 10); % healthy-average
d_avg = zeros(1, 10); % diabetic-average
h_min = zeros(1, 10); % healthy-minimum
d_min = zeros(1, 10); % diabetic-minimum
h_max = zeros(1, 10); % healthy-maximum
d_max = zeros(1, 10); % diabetic-maximum

x = 1 : 10;

for i = 1 : 10
% Healthy
h_f(i) = round(normrnd(80, 1));
h_notF(i) = round(normrnd(130, 1));

% Diabetic
d_f(i) = round(normrnd(140, 1));
d_notF(i) = round(normrnd(250, 1));
end

% Group average signal
for i = 1 : 10
    h_avg(i) = (h_f(i) + h_notF(i)) / 2;
    d_avg(i) = (d_f(i) + d_notF(i)) / 2;
end

% Feature extraction: minimum and maximum
for i = 1 : 10
    h_min(i) = h_f(i);
    d_min(i) = d_f(i);
    h_max(i) = h_notF(i);
    d_max(i) = d_notF(i);
end

% 1. Plot the group average signal
figure, plot(x, h_avg, x, d_avg);
title('Group Average Signal')

% As a suggest the features that could differentiate 
% between the two groups we can chose average, minimum, and maximum
% 4. Plot the scatter plot for each extracted feature

% Average
figure, subplot(1,3,1), scatter(x,h_avg)
hold on
scatter(x, d_avg,'*')
hold off
title('Average Feature')
ylabel('Number of repeatition')
xlabel('Feature values')
legend('healthy','diabetic')
legend boxoff

% Maximum
subplot(1,3,2), scatter(x,h_max)
hold on
scatter(x, d_max,'*')
hold off
title('Maximum Feature')
ylabel('Number of repeatition')
xlabel('Feature values')
legend('healthy','diabetic')
legend boxoff

% Minimum
subplot(1,3,3), scatter(x,h_min)
hold on
scatter(x, d_min,'*')
hold off
title('Minimum Feature')
ylabel('Number of repeatition')
xlabel('Feature values')
legend('healthy','diabetic')
legend boxoff


% 5. Plot the histogram for each extracted feature

% Average
figure, subplot(1,3,1), histogram(h_avg)
hold on
histogram(d_avg)
hold off
title('Average Feature')
ylabel('Number of repeatition')
xlabel('Feature values')
legend('healthy','diabetic')
legend boxoff

% Maximum
subplot(1,3,2), histogram(h_max)
hold on
histogram(d_max)
hold off
title('Maximum Feature')
ylabel('Number of repeatition')
xlabel('Feature values')
legend('healthy','diabetic')
legend boxoff

% Minimum
subplot(1,3,3), histogram(h_min)
hold on
histogram(d_min)
hold off
title('Minimum Feature')
ylabel('Number of repeatition')
xlabel('Feature values')
legend('healthy','diabetic')
legend boxoff

% As a suggest the suitable statistical test between groups
% we chose F test

% Tables for data
% Healthy people data
HealthyCases = 1 : 10;
HealthyCases = HealthyCases';
Fast = h_f';
NotFast = h_notF';
HealthData = table(HealthyCases, Fast, NotFast)
writetable(HealthData);

% Diabetic people data
DiabetcCases = 1 : 10;
DiabetcCases = DiabetcCases';
Fast = d_f';
NotFast = d_notF';
DiabeticData = table(DiabetcCases, Fast, NotFast)
writetable(DiabeticData);

% Feature data
Cases = {'h1'; 'h2'; 'h3'; 'h4'; 'h5'; 'h6'; 'h7'; 'h8'; 'h9'; 'h10';...
    'd1'; 'd2'; 'd3'; 'd4'; 'd5'; 'd6'; 'd7'; 'd8'; 'd9'; 'd10'};
Max = [h_max d_max]';
Min = [h_min d_min]';
Avg = [h_avg d_avg]';
Feature = table(Cases, Max, Min, Avg)
writetable(Feature);

% Group average feature data
Cases = {'Healthy'; 'Diabetic'};
Max = [max(h_max) max(d_max)]';
Min = [min(h_min) min(d_min)]';
Avg = [mean([Max(1) Min(1)]) mean([Max(2) Min(2)])]';
GroupAvgFeature = table(Cases, Max, Min, Avg)
writetable(GroupAvgFeature);

 

