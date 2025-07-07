% Black-winged Kite Algorithm (BKA)
function [Best_Fitness, Best_Pos, Convergence_curve] = BKA(N, MaxIt, lb, ub, dim, fobj)
    % ����˵����
    % N - ��Ⱥ����
    % MaxIt - ����������
    % lb, ub - �����ռ����½�
    % dim - ά��
    % fobj - Ŀ�꺯��

    p = 0.9;
    Positions = initialization(N, dim, ub, lb); % ��ͨ��ʼ��
    Fitness = arrayfun(@(i) fobj(Positions(i,:)), 1:N);
    [Best_Fitness, idx] = min(Fitness);
    Best_Pos = Positions(idx, :);
    Convergence_curve = zeros(1, MaxIt);



    % ��ѭ��
    for it = 1:MaxIt
        r = rand;
        
        % ������Ϊ
        for i = 1:N
            n = 0.05 * exp(-2 * (it/MaxIt)^2);
            if p < r
                New_Pos = Positions(i,:) + n * (1 + sin(r)) * Positions(i,:);
            else
                New_Pos = Positions(i,:) .* (n * (2*rand(1,dim) - 1) + 1);
            end
            
            % �߽紦��
            New_Pos = max(New_Pos, lb);
            New_Pos = min(New_Pos, ub);
            
            % ����λ��
            New_Fitness = fobj(New_Pos);
            if New_Fitness < Fitness(i)
                Positions(i,:) = New_Pos;
                Fitness(i) = New_Fitness;
            end
        end

        % Ǩ����Ϊ
        for i = 1:N
            m = 2 * sin(r + pi/2);
            s = randi([1, N], 1); % ���ѡ��һ������
            r_Fitness = Fitness(s);
            
            cauchy_value = tan((rand(1,dim) - 0.5) * pi); % �����Ŷ�
            
            if Fitness(i) < r_Fitness
                New_Pos = Positions(i,:) + cauchy_value .* (Positions(i,:) - Best_Pos);
            else
                New_Pos = Positions(i,:) + cauchy_value .* (Best_Pos - m * Positions(i,:));
            end
            
            % �߽紦��
            New_Pos = max(New_Pos, lb);
            New_Pos = min(New_Pos, ub);
            
            % ����λ��
            New_Fitness = fobj(New_Pos);
            if New_Fitness < Fitness(i)
                Positions(i,:) = New_Pos;
                Fitness(i) = New_Fitness;
            end
        end

        % ����ȫ������
        [Current_Best_Fitness, idx] = min(Fitness);
        if Current_Best_Fitness < Best_Fitness
            Best_Fitness = Current_Best_Fitness;
            Best_Pos = Positions(idx, :);
        end
        
        % ��¼��������
        Convergence_curve(it) = Best_Fitness;
    end
end