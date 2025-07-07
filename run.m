

% 清除工作区和命令窗口
clear all; 
close all; 
clc;

% 初始化运行次数和实验结果存储单元
runs = 5; 
Optimal_results = cell(4, 13); % 因为要存储原始BKA和12种反向学习类型的结果，所以列数设为13

% 添加算法所在路径
addpath(genpath('Swarm-Opti'));

% 设置参数
nPop = 50; % 种群数量
Max_iter = 300; % 最大迭代次数
Function_name = 'F23'; %  F1 to F23
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

% 绘制基准函数图形
func_plot(Function_name);

% 运行 BKA 算法
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = BKA(nPop, Max_iter, lb, ub, dim, fobj);
    Optimal_results{1, 1} = "BKA";
    Optimal_results{2, 1}(run_time, :) = cg_curve;
    Optimal_results{3, 1}(run_time, :) = Best_score;
    Optimal_results{4, 1}(run_time, :) = Best_pos;
end

% 反向学习类型 1
obl_type = 1;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 2} = "BKA-OBL";
    Optimal_results{2, 2}(run_time, :) = cg_curve;
    Optimal_results{3, 2}(run_time, :) = Best_score;
    Optimal_results{4, 2}(run_time, :) = Best_pos;
end

% 反向学习类型 2
obl_type = 2;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 3} = "BKA-AOBL";
    Optimal_results{2, 3}(run_time, :) = cg_curve;
    Optimal_results{3, 3}(run_time, :) = Best_score;
    Optimal_results{4, 3}(run_time, :) = Best_pos;
end

% 反向学习类型 3
obl_type = 3;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 4} = "BKA-IOBL";
    Optimal_results{2, 4}(run_time, :) = cg_curve;
    Optimal_results{3, 4}(run_time, :) = Best_score;
    Optimal_results{4, 4}(run_time, :) = Best_pos;
end

% 反向学习类型 4
obl_type = 4;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 5} = "BKA-COBL";
    Optimal_results{2, 5}(run_time, :) = cg_curve;
    Optimal_results{3, 5}(run_time, :) = Best_score;
    Optimal_results{4, 5}(run_time, :) = Best_pos;
end

% 反向学习类型 5
obl_type = 5;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 6} = "BKA-EOBL";
    Optimal_results{2, 6}(run_time, :) = cg_curve;
    Optimal_results{3, 6}(run_time, :) = Best_score;
    Optimal_results{4, 6}(run_time, :) = Best_pos;
end

% 反向学习类型 6
obl_type = 6;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 7} = "BKA-DOBL";
    Optimal_results{2, 7}(run_time, :) = cg_curve;
    Optimal_results{3, 7}(run_time, :) = Best_score;
    Optimal_results{4, 7}(run_time, :) = Best_pos;
end

% 反向学习类型 7
obl_type = 7;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 8} = "BKA-FROBL";
    Optimal_results{2, 8}(run_time, :) = cg_curve;
    Optimal_results{3, 8}(run_time, :) = Best_score;
    Optimal_results{4, 8}(run_time, :) = Best_pos;
end

% 反向学习类型 8
obl_type = 8;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 9} = "BKA-SOBL";
    Optimal_results{2, 9}(run_time, :) = cg_curve;
    Optimal_results{3, 9}(run_time, :) = Best_score;
    Optimal_results{4, 9}(run_time, :) = Best_pos;
end

% 反向学习类型 9
obl_type = 9;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 10} = "BKA-QOBL";
    Optimal_results{2, 10}(run_time, :) = cg_curve;
    Optimal_results{3, 10}(run_time, :) = Best_score;
    Optimal_results{4, 10}(run_time, :) = Best_pos;
end

% 反向学习类型 10
obl_type = 10;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 11} = "BKA-LSOBL";
    Optimal_results{2, 11}(run_time, :) = cg_curve;
    Optimal_results{3, 11}(run_time, :) = Best_score;
    Optimal_results{4, 11}(run_time, :) = Best_pos;
end

% 反向学习类型 11
obl_type = 11;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 12} = "BKA-BOBL";
    Optimal_results{2, 12}(run_time, :) = cg_curve;
    Optimal_results{3, 12}(run_time, :) = Best_score;
    Optimal_results{4, 12}(run_time, :) = Best_pos;
end

% 反向学习类型 12
obl_type = 12;
for run_time = 1:runs
    [Best_score, Best_pos, cg_curve] = OBL_BKA(nPop, Max_iter, lb, ub, dim, fobj, obl_type);
    Optimal_results{1, 13} = "BKA-WOBL"; % 假设类型12命名为BKA-WOBL，可按需修改
    Optimal_results{2, 13}(run_time, :) = cg_curve;
    Optimal_results{3, 13}(run_time, :) = Best_score;
    Optimal_results{4, 13}(run_time, :) = Best_pos;
end

% 移除路径
rmpath(genpath('Swarm-Opti'));

% 绘制收敛曲线
figure;

% 稍深的柔和配色方案（RGB，范围0~1）
soft_colors = [
    0.4 0.4 0.8;
    0.8 0.4 0.4;
    0.3 0.7 0.3;
    0.7 0.7 0.3;
    0.3 0.7 0.7;
    0.6 0.4 0.8;
    0.8 0.5 0.2;
    0.3 0.8 0.8;
    0.8 0.3 0.5;
    0.4 0.8 0.3;
    0.8 0.7 0.2;
    0.5 0.4 0.8;
    0.3 0.4 0.8
];

for i = 1:13
    Mean_convergence = mean(Optimal_results{2, i}, 1);
    semilogy(Mean_convergence, 'LineWidth', 1.5, 'Color', soft_colors(i, :));
    hold on;
end

xlabel('Iteration');
ylabel('Best Fitness');
title('(f) OBL-enhanced BKA Convergence');
legend(Optimal_results{1, :}, 'Location', 'best');
grid on;

% 设置虚线背景网格
set(gca, 'GridLineStyle', '--', 'XMinorGrid', 'on', 'YMinorGrid', 'on');

% 控制网格密度（可选）
xticks(0:50:Max_iter);
ytickformat('%.1e');

hold off;


% 计算排名
[~, sorted_indices] = sort([Optimal_results{3, 1:13}]', 'ascend');
ranking = zeros(1, 13);
for i = 1:13
    ranking(sorted_indices(i)) = i;
end

% 输出排名
disp('算法排名：');
for i = 1:13
    fprintf('%s: 第 %d 名\n', char(Optimal_results{1, i}), ranking(i));
end