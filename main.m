

%% 主程序：BKA及其混沌改进版本对比
clc; clear; close all;

%% 参数设置
SearchAgents = 50;    % 种群数量
Function_name = 'F13'; % 测试函数
Max_iteration = 300;   % 最大迭代次数
runs = 5;              % 每个算法运行次数

%% 获取函数信息
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

%% 混沌映射名称定义（与chaos.m顺序严格一致）
chaos_names = {
    'Chebyshev', 'Circle', 'Gauss', 'Iterative', 'Logistic',...
    'Piecewise', 'Sine', 'Singer', 'Sinusoidal', 'Tent',...
    'Fuch', 'SPM', 'ICMIC', 'Tent-Logistic-Cosine',...
    'Sine-Tent-Cosine', 'Logistic-Sine-Cosine', 'Henon',...
    'Cubic', 'Logistic-Tent', 'Bernoulli', 'Kent'
};
num_chaos = length(chaos_names); % 应等于21

%% 初始化结果存储
algor_name = {};
all_curves = {}; % 存储所有收敛曲线
Best_scores = []; % 存储最终适应度值

%% ======================== 运行算法 ========================
id = 1;

% ---------------------- 原始BKA算法 ----------------------
algor_name{1, id} = 'BKA';
temp_curves = zeros(runs, Max_iteration);
temp_scores = zeros(1, runs);

for run = 1:runs
    [Best_score, ~, cg_curve] = BKA(SearchAgents, Max_iteration, lb, ub, dim, fobj);
    temp_curves(run, :) = cg_curve;
    temp_scores(run) = Best_score;
end

all_curves{id} = mean(temp_curves, 1); % 取平均
Best_scores(id) = mean(temp_scores);
id = id + 1;

% ------------------ 21种混沌改进的BKA算法 ------------------
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

%% ======================== 结果展示 ========================
% ---------------------- 绘制收敛曲线 ----------------------
figure('Position', [100 200 400 300]);
func_plot(Function_name);
title(Function_name);
xlabel('x_1'); ylabel('x_2'); zlabel([Function_name, '(x_1, x_2)']);

figure('Position', [500 200 550 270]);
hold on;
colors = jet(num_chaos+1); % +1包含原始BKA
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
lgd.NumColumns = 2; % 设置为7列
lgd.Box = 'on';     % 可选：加个边框更清晰

grid on;
hold off;

% -------------------- 文字输出排序结果 --------------------
% 构建结果表格
result_table = table();
result_table.Algorithm = algor_name';
result_table.AverageFitness = Best_scores';

% 按适应度排序（从小到大）
[~, idx] = sort(result_table.AverageFitness);
sorted_table = result_table(idx, :);

% 打印结果
fprintf('\n=============== 算法性能排序 (平均适应度) ===============\n');
fprintf('%-30s %s\n', 'Algorithm', 'Average Fitness');
fprintf('------------------------------------------------\n');
for i = 1:height(sorted_table)
    fprintf('%-30s %.4e\n', sorted_table.Algorithm{i}, sorted_table.AverageFitness(i));
end
fprintf('====================================================\n\n');