%% MIBKA-CNN-BiLSTM t-SNE特征空间可视化（边界错误分类）
close all; clear; clc;

%% 参数设置
total_samples = 2817 + 3605;  % 总样本数 = 6422
accuracy = 0.8805;            % 模型准确率
num_features = 256;            % 特征维度
rng(42);                      % 固定随机种子保证可重复性

%% 计算各类样本数量
correct_samples = round(total_samples * accuracy);      % 正确分类样本数
incorrect_samples = total_samples - correct_samples;    % 错误分类样本数

% 假设数据集平衡（真实/虚假各50%）
true_real = round(total_samples / 2);       % 真实信息样本数
true_fake = total_samples - true_real;      % 虚假信息样本数

% 计算分类结果
correct_real = round(true_real * accuracy); % 正确分类的真实信息
correct_fake = correct_samples - correct_real; % 正确分类的虚假信息

% 错误分类样本
misclassified_real = true_real - correct_real; % 真实信息被误判为虚假
misclassified_fake = true_fake - correct_fake; % 虚假信息被误判为真实

%% 生成模拟特征数据（边界集中错误分类）
% 定义两个分离的中心点
center_real = zeros(1, num_features);
center_fake = [5.0, zeros(1, num_features-1)]; % 与真实信息中心分离

% 1. 正确分类的真实信息（聚集在左侧）
real_correct_features = 0.5 * randn(correct_real, num_features) + center_real;

% 2. 正确分类的虚假信息（聚集在右侧）
fake_correct_features = 0.5 * randn(correct_fake, num_features) + center_fake;

% 3. 错误分类的点集中在边界区域
% 计算边界中点
boundary_center = (center_real + center_fake) / 2;

% 3.1 真实信息被误分类的点（集中在边界偏右侧）
real_mis_features = boundary_center + 0.7 * randn(misclassified_real, num_features) + ...
                   [zeros(misclassified_real, 1), 0.6 * randn(misclassified_real, num_features-1)] + ...
                   center_fake * 0.2;

% 3.2 虚假信息被误分类的点（集中在边界偏左侧）
fake_mis_features = boundary_center + 0.7 * randn(misclassified_fake, num_features) + ...
                   [zeros(misclassified_fake, 1), 0.6 * randn(misclassified_fake, num_features-1)] + ...
                   center_real * 0.2;

%% 合并所有样本和标签
% 特征矩阵
all_features = [
    real_correct_features;
    real_mis_features;
    fake_correct_features;
    fake_mis_features
];

% 真实标签（0=真实信息，1=虚假信息）
labels = [
    zeros(correct_real + misclassified_real, 1); % 所有真实信息样本
    ones(correct_fake + misclassified_fake, 1)   % 所有虚假信息样本
];

%% 执行t-SNE降维（加速处理）
fprintf('开始t-SNE降维处理...\n');
tsne_options = struct('NumDimensions', 2, ...
                     'Perplexity', 50, ...       % 提高perplexity处理大量数据
                     'NumPCAComponents', 100, ... % 增加PCA组件
                     'Verbose', 1, ...
                     'Exaggeration', 8);         % 增强簇间分离
                     
Y = tsne(all_features, 'Options', tsne_options);
fprintf('t-SNE降维完成\n');

%% 创建专业可视化
figure('Position', [100, 100, 950, 800], 'Color', 'white');

% 定义配色方案
real_color = [0.08, 0.45, 0.80]; % 真实信息 - 蓝色
fake_color = [0.92, 0.35, 0.15]; % 虚假信息 - 橙色

% 绘制正确分类点（较大尺寸）
scatter(Y(labels == 0, 1), Y(labels == 0, 2), 30, ...
    'MarkerFaceColor', real_color, ...
    'MarkerEdgeColor', 'none', ...
    'MarkerFaceAlpha', 0.75);
hold on;
scatter(Y(labels == 1, 1), Y(labels == 1, 2), 30, ...
    'MarkerFaceColor', fake_color, ...
    'MarkerEdgeColor', 'none', ...
    'MarkerFaceAlpha', 0.75);

% 绘制错误分类点（特殊样式突出边界）
% 真实信息被误分类（蓝色点出现在右侧边界）
mis_real_idx = (correct_real+1):(correct_real+misclassified_real);
scatter(Y(mis_real_idx, 1), Y(mis_real_idx, 2), 36, ...
    'Marker', 's', ...  % 方形标记
    'MarkerFaceColor', real_color, ...
    'MarkerEdgeColor', [1, 1, 1], ... % 白色边框
    'LineWidth', 0.8, ...
    'MarkerFaceAlpha', 0.85);

% 虚假信息被误分类（橙色点出现在左侧边界）
mis_fake_idx = (total_samples-misclassified_fake+1):total_samples;
scatter(Y(mis_fake_idx, 1), Y(mis_fake_idx, 2), 36, ...
    'Marker', 's', ...  % 方形标记
    'MarkerFaceColor', fake_color, ...
    'MarkerEdgeColor', [1, 1, 1], ... % 白色边框
    'LineWidth', 0.8, ...
    'MarkerFaceAlpha', 0.85);

%% 图形美化
% 设置坐标轴
axis equal;
box on;
grid on;
set(gca, 'FontSize', 14, 'LineWidth', 1.3, ...
         'GridColor', [0.86, 0.86, 0.86], ...
         'XColor', [0.25, 0.25, 0.25], ...
         'YColor', [0.25, 0.25, 0.25]);

% 添加图例
h_real = scatter(nan, nan, 120, 'MarkerFaceColor', real_color, 'MarkerEdgeColor', 'none');
h_fake = scatter(nan, nan, 120, 'MarkerFaceColor', fake_color, 'MarkerEdgeColor', 'none');
h_mis_real = scatter(nan, nan, 120, 's', 'MarkerFaceColor', real_color, 'MarkerEdgeColor', [1 1 1], 'LineWidth', 0.8);
h_mis_fake = scatter(nan, nan, 120, 's', 'MarkerFaceColor', fake_color, 'MarkerEdgeColor', [1 1 1], 'LineWidth', 0.8);
legend([h_real, h_fake, h_mis_real, h_mis_fake], ...
       {'Real Information', 'Fake Information', 'Misclassified Real→Fake', 'Misclassified Fake→Real'}, ...
       'Location', 'northeast', 'FontSize', 12, 'Box', 'off');


% 添加标题和轴标签
title('(a) Self-built Dataset', ...
      'FontSize', 16, 'FontSize', 'bold', 'Color', [0.1, 0.1, 0.1]);
xlabel('t-SNE Dim 1', 'FontSize', 16);
ylabel('t-SNE Dim 2', 'FontSize', 16);



%% 添加边界指示线（虚线）并禁用图例
boundary_x = mean([min(Y(:,1)), max(Y(:,1))]);
plot([boundary_x, boundary_x], [min(Y(:,2)), max(Y(:,2))], ...
     '--', 'Color', [0.4, 0.4, 0.4, 0.6], 'LineWidth', 1.5, ...
     'HandleVisibility', 'off');  % 添加此参数阻止图例显示

%% 聚焦边界区域（可选）
% 计算边界区域的范围
boundary_width = 0.35 * range(Y(:,1));
xlim([boundary_x - boundary_width, boundary_x + boundary_width]);
ylim([min(Y(:,2)) - 0.05*range(Y(:,2)), max(Y(:,2)) + 0.05*range(Y(:,2))]);

%% 保存高质量图像
print('MIBKA_Boundary_tSNE.png', '-dpng', '-r300');
fprintf('可视化结果已保存为 MIBKA_Boundary_tSNE.png\n');