% -------------------------------------------------------------------------
% Chaos-enhanced Black-winged Kite Algorithm (Chaos_BKA)
% 带混沌初始化的BKA改进算法
% -------------------------------------------------------------------------
function [Best_Fitness, Best_Pos, Convergence_curve] = Chaos_BKA(N, MaxIt, lb, ub, dim, fobj, chaos_index)
    % 输入参数:
    % N            - 种群规模
    % MaxIt        - 最大迭代次数
    % lb           - 搜索空间下限 (1×dim向量)
    % ub           - 搜索空间上限 (1×dim向量)
    % dim          - 问题维度
    % fobj         - 目标函数句柄
    % chaos_index  - 混沌映射类型索引 (1-21)

    % 输出参数:
    % Best_Fitness - 历史最优适应度值
    % Best_Pos     - 历史最优解位置
    % Convergence_curve - 收敛曲线

    %% 算法参数设置
    p = 0.9;       % 攻击行为概率参数
    Convergence_curve = zeros(1, MaxIt); % 收敛曲线初始化

    %% 混沌初始化种群
    Positions = Chaos_initialization(N, dim, ub, lb, chaos_index); % 关键修改点
    
    %% 计算初始适应度
    Fitness = zeros(1, N);
    for i = 1:N
        Fitness(i) = fobj(Positions(i,:));
    end
    
    %% 记录初始最优解
    [Best_Fitness, idx] = min(Fitness);
    Best_Pos = Positions(idx, :);

    %% 主优化循环
    for it = 1:MaxIt
        r = rand; % 随机因子 (每次迭代重新生成)
        
        %% ================= 攻击行为 =================
        for i = 1:N
            % 动态参数计算
            n = 0.05 * exp(-2 * (it/MaxIt)^2);  % 非线性递减因子
            
            % 位置更新策略
            if p < r
                New_Pos = Positions(i,:) + n * (1 + sin(r)) * Positions(i,:);
            else
                New_Pos = Positions(i,:) .* (n * (2*rand(1,dim) - 1) + 1);
            end
            
            % 边界约束处理
            New_Pos = max(New_Pos, lb);
            New_Pos = min(New_Pos, ub);
            
            % 评估新位置
            New_Fitness = fobj(New_Pos);
            
            % 贪婪选择
            if New_Fitness < Fitness(i)
                Positions(i,:) = New_Pos;
                Fitness(i) = New_Fitness;
            end
        end

        %% ================= 迁移行为 =================
        for i = 1:N
            m = 2 * sin(r + pi/2);   % 迁移系数
            s = randi([1, N], 1);    % 随机选择个体索引
            r_Fitness = Fitness(s);  % 随机个体适应度
            
            % 生成柯西扰动
            cauchy_value = tan((rand(1,dim) - 0.5) * pi);
            
            % 迁移策略
            if Fitness(i) < r_Fitness
                New_Pos = Positions(i,:) + cauchy_value .* (Positions(i,:) - Best_Pos);
            else
                New_Pos = Positions(i,:) + cauchy_value .* (Best_Pos - m.*Positions(i,:));
            end
            
            % 边界约束处理
            New_Pos = max(New_Pos, lb);
            New_Pos = min(New_Pos, ub);
            
            % 评估新位置
            New_Fitness = fobj(New_Pos);
            
            % 贪婪选择
            if New_Fitness < Fitness(i)
                Positions(i,:) = New_Pos;
                Fitness(i) = New_Fitness;
            end
        end

        %% =============== 更新全局最优解 ===============
        [Current_Best_Fitness, idx] = min(Fitness);
        if Current_Best_Fitness < Best_Fitness
            Best_Fitness = Current_Best_Fitness;
            Best_Pos = Positions(idx, :);
        end
        
        %% 记录收敛曲线
        Convergence_curve(it) = Best_Fitness;
        
        %% 显示迭代信息 (可选)
        % disp(['Iteration ' num2str(it) ': Best Fitness = ' num2str(Best_Fitness)]);
    end
end