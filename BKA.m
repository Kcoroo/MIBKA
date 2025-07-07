% Black-winged Kite Algorithm (BKA)
function [Best_Fitness, Best_Pos, Convergence_curve] = BKA(N, MaxIt, lb, ub, dim, fobj)
    % 参数说明：
    % N - 种群数量
    % MaxIt - 最大迭代次数
    % lb, ub - 搜索空间上下界
    % dim - 维度
    % fobj - 目标函数

    p = 0.9;
    Positions = initialization(N, dim, ub, lb); % 普通初始化
    Fitness = arrayfun(@(i) fobj(Positions(i,:)), 1:N);
    [Best_Fitness, idx] = min(Fitness);
    Best_Pos = Positions(idx, :);
    Convergence_curve = zeros(1, MaxIt);



    % 主循环
    for it = 1:MaxIt
        r = rand;
        
        % 攻击行为
        for i = 1:N
            n = 0.05 * exp(-2 * (it/MaxIt)^2);
            if p < r
                New_Pos = Positions(i,:) + n * (1 + sin(r)) * Positions(i,:);
            else
                New_Pos = Positions(i,:) .* (n * (2*rand(1,dim) - 1) + 1);
            end
            
            % 边界处理
            New_Pos = max(New_Pos, lb);
            New_Pos = min(New_Pos, ub);
            
            % 更新位置
            New_Fitness = fobj(New_Pos);
            if New_Fitness < Fitness(i)
                Positions(i,:) = New_Pos;
                Fitness(i) = New_Fitness;
            end
        end

        % 迁移行为
        for i = 1:N
            m = 2 * sin(r + pi/2);
            s = randi([1, N], 1); % 随机选择一个个体
            r_Fitness = Fitness(s);
            
            cauchy_value = tan((rand(1,dim) - 0.5) * pi); % 柯西扰动
            
            if Fitness(i) < r_Fitness
                New_Pos = Positions(i,:) + cauchy_value .* (Positions(i,:) - Best_Pos);
            else
                New_Pos = Positions(i,:) + cauchy_value .* (Best_Pos - m * Positions(i,:));
            end
            
            % 边界处理
            New_Pos = max(New_Pos, lb);
            New_Pos = min(New_Pos, ub);
            
            % 更新位置
            New_Fitness = fobj(New_Pos);
            if New_Fitness < Fitness(i)
                Positions(i,:) = New_Pos;
                Fitness(i) = New_Fitness;
            end
        end

        % 更新全局最优
        [Current_Best_Fitness, idx] = min(Fitness);
        if Current_Best_Fitness < Best_Fitness
            Best_Fitness = Current_Best_Fitness;
            Best_Pos = Positions(idx, :);
        end
        
        % 记录收敛曲线
        Convergence_curve(it) = Best_Fitness;
    end
end