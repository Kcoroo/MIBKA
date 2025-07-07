

function [Bestscore, Best_pos, Convergence_curve] = OBL_BKA(N, Maxits, lb, ub, dim, fobj, op_type)
    p = 0.9;
    Bestscore = inf;
    Best_pos = zeros(1, dim);
    Convergence_curve = zeros(1, Maxits);
    
    % 初始化种群
    XPos = initialization(N, dim, ub, lb);
    XFit = zeros(N, 1);
    
    % 计算初始适应度
    for i = 1:N
        XFit(i) = fobj(XPos(i, :));
    end
    
    % 排序并设置初始最优
    [~, SortOrder] = sort(XFit);
    XPos = XPos(SortOrder, :);
    Best_pos = XPos(1, :);
    Bestscore = XFit(SortOrder(1));
    Convergence_curve(1) = Bestscore;
    
    %% 主循环
    for it = 1:Maxits
        r = rand;
        [current_best, idx] = min(XFit);
        XLeader_Pos = XPos(idx, :);
        
        %% 探索行为
        for i = 1:N
            n = 0.05 * exp(-2*(it/Maxits)^2);
            if p < r
                XPosNew(i,:) = XPos(i,:) + n.*(1+sin(r)).*XPos(i,:);
            else
                XPosNew(i,:) = XPos(i,:).*(n*(2*rand(1,dim)-1)+1);
            end
            XPosNew(i,:) = max(min(XPosNew(i,:), ub), lb);
            XFit_New(i) = fobj(XPosNew(i,:));
            
            if XFit_New(i) < XFit(i)
                XPos(i,:) = XPosNew(i,:);
                XFit(i) = XFit_New(i);
            end
            
            %% 开发行为
            m = 2*sin(r+pi/2);
            s = randi([1,N]);
            r_XFitness = XFit(s);
            ori_value = rand(1,dim);
            cauchy_value = tan((ori_value-0.5)*pi);
            
            if XFit(i) < r_XFitness
                XPosNew(i,:) = XPos(i,:) + cauchy_value.*(XPos(i,:)-XLeader_Pos);
            else
                XPosNew(i,:) = XPos(i,:) + cauchy_value.*(XLeader_Pos - m.*XPos(i,:));
            end
            XPosNew(i,:) = max(min(XPosNew(i,:), ub), lb);
            XFit_New(i) = fobj(XPosNew(i,:));
            
            if XFit_New(i) < XFit(i)
                XPos(i,:) = XPosNew(i,:);
                XFit(i) = XFit_New(i);
            end
        end
        
        %% 反向学习
        [XPos, Best_pos, Bestscore] = Opposition_Based_Learning(...
            XPos, it, Maxits, Best_pos, Bestscore, lb, ub, fobj, op_type);
        
        % 更新适应度值（新增关键代码）
        for i = 1:N
            XFit(i) = fobj(XPos(i, :));
        end
        
        %% 更新收敛曲线
        [Bestscore, idx] = min(XFit);
        Best_pos = XPos(idx, :);
        Convergence_curve(it) = Bestscore;
    end
end