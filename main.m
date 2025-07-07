

%% ������BKA�������Ľ��汾�Ա�
clc; clear; close all;

%% ��������
SearchAgents = 50;    % ��Ⱥ����
Function_name = 'F13'; % ���Ժ���
Max_iteration = 300;   % ����������
runs = 5;              % ÿ���㷨���д���

%% ��ȡ������Ϣ
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

%% ����ӳ�����ƶ��壨��chaos.m˳���ϸ�һ�£�
chaos_names = {
    'Chebyshev', 'Circle', 'Gauss', 'Iterative', 'Logistic',...
    'Piecewise', 'Sine', 'Singer', 'Sinusoidal', 'Tent',...
    'Fuch', 'SPM', 'ICMIC', 'Tent-Logistic-Cosine',...
    'Sine-Tent-Cosine', 'Logistic-Sine-Cosine', 'Henon',...
    'Cubic', 'Logistic-Tent', 'Bernoulli', 'Kent'
};
num_chaos = length(chaos_names); % Ӧ����21

%% ��ʼ������洢
algor_name = {};
all_curves = {}; % �洢������������
Best_scores = []; % �洢������Ӧ��ֵ

%% ======================== �����㷨 ========================
id = 1;

% ---------------------- ԭʼBKA�㷨 ----------------------
algor_name{1, id} = 'BKA';
temp_curves = zeros(runs, Max_iteration);
temp_scores = zeros(1, runs);

for run = 1:runs
    [Best_score, ~, cg_curve] = BKA(SearchAgents, Max_iteration, lb, ub, dim, fobj);
    temp_curves(run, :) = cg_curve;
    temp_scores(run) = Best_score;
end

all_curves{id} = mean(temp_curves, 1); % ȡƽ��
Best_scores(id) = mean(temp_scores);
id = id + 1;

% ------------------ 21�ֻ���Ľ���BKA�㷨 ------------------
for chaos_index = 1:num_chaos
    algo_name = ['BKA-', chaos_names{chaos_index}];
    algor_name{1, id} = algo_name;
    
    temp_curves = zeros(runs, Max_iteration);
    temp_scores = zeros(1, runs);
    
    for run = 1:runs
        [Best_score, ~, cg_curve] = Chaos_BKA(SearchAgents, Max_iteration, lb, ub, dim, fobj, chaos_index);
        temp_curves(run, :) = cg_curve;
        temp_scores(run) = Best_score;
    end
    
    all_curves{id} = mean(temp_curves, 1);
    Best_scores(id) = mean(temp_scores);
    id = id + 1;
end

%% ======================== ���չʾ ========================
% ---------------------- ������������ ----------------------
figure('Position', [100 200 400 300]);
func_plot(Function_name);
title(Function_name);
xlabel('x_1'); ylabel('x_2'); zlabel([Function_name, '(x_1, x_2)']);

figure('Position', [500 200 550 270]);
hold on;
colors = jet(num_chaos+1); % +1����ԭʼBKA
line_styles = {'-', '--', ':', '-.'};

for i = 1:length(algor_name)
    style_idx = mod(i-1, length(line_styles)) + 1;
    semilogy(all_curves{i}, 'Color', colors(i,:),...
        'LineStyle', line_styles{style_idx},...
        'LineWidth', 1.5);
end

title('(f) Chaos-enhanced BKA Convergence');
xlabel('Iteration'); ylabel('Best Fitness');
lgd = legend(algor_name, 'FontSize', 7, 'Location', 'northeast');
lgd.NumColumns = 2; % ����Ϊ7��
lgd.Box = 'on';     % ��ѡ���Ӹ��߿������

grid on;
hold off;

% -------------------- ������������� --------------------
% ����������
result_table = table();
result_table.Algorithm = algor_name';
result_table.AverageFitness = Best_scores';

% ����Ӧ�����򣨴�С����
[~, idx] = sort(result_table.AverageFitness);
sorted_table = result_table(idx, :);

% ��ӡ���
fprintf('\n=============== �㷨�������� (ƽ����Ӧ��) ===============\n');
fprintf('%-30s %s\n', 'Algorithm', 'Average Fitness');
fprintf('------------------------------------------------\n');
for i = 1:height(sorted_table)
    fprintf('%-30s %.4e\n', sorted_table.Algorithm{i}, sorted_table.AverageFitness(i));
end
fprintf('====================================================\n\n');