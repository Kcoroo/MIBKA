

function [pop,bestx,besty]=Opposition_Based_Learning(pop,iter,max_iter,bestx,besty,lb,ub,fobj,obl_type)
    lb = lb.*ones(1, size(pop, 2));
    ub = ub.*ones(1, size(pop, 2));

    switch obl_type
        case 1
            % 基本反向学习策略
            swarm_opti = ub + lb - pop;
            % 边界处理
            swarm_opti = max(min(swarm_opti, ub), lb);

            original_fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                original_fitness(i) = fobj(pop(i, :));
            end

            op_fitness = zeros(size(swarm_opti, 1), 1);
            for i = 1:size(swarm_opti, 1)
                op_fitness(i) = fobj(swarm_opti(i, :));
            end

            for i = 1:size(pop, 1)
                if op_fitness(i) < original_fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    original_fitness(i) = op_fitness(i);
                end

                if op_fitness(i) < besty
                    besty = op_fitness(i);
                    bestx = swarm_opti(i, :);
                end
            end

        case 2
            % 自适应反向学习策略
            k = (1 + (iter / max_iter)^0.5)^8;
            swarm_opti = (ub + lb) / 2 + (ub + lb) / (2 * k) - pop / k;
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 3
            % 改进的反向学习策略
            k = rand;
            swarm_opti = (0.5 * k + 0.5) * (ub + lb) - k * pop;
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 4
            % 混沌反向学习策略
            z = mean(pop);
            k = rand;
            swarm_opti = 2 * k * z - pop;
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 5
            % 精英反向学习
            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
            end
            [~, SortOrder] = sort(fitness);
            pop = pop(SortOrder, :);
            N = floor(size(pop, 1) / 2);

            swarm_opti = rand * (lb + ub) - pop(1:N, :);
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            new_pop = [pop; swarm_opti];
            new_fitness = [fitness; zeros(size(swarm_opti, 1), 1)];
            for i = 1:size(swarm_opti, 1)
                new_fitness(end - size(swarm_opti, 1) + i) = fobj(swarm_opti(i, :));
            end

            [new_fitness, SortOrder] = sort(new_fitness);
            new_pop = new_pop(SortOrder, :);
            pop = new_pop(1:size(pop, 1), :);

            if new_fitness(1) < besty
                besty = new_fitness(1);
                bestx = new_pop(1, :);
            end

        case 6
            % 动态反向学习
            d_max = max(pop, [], 1);
            d_min = min(pop, [], 1);
            swarm_opti = d_max + d_min - pop;
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 7
            % 快速随机反向学习 (FROBL)
            M = (lb + ub) / 2;
            for i = 1:size(pop, 1)
                if norm(pop(i, :)) < norm(M)
                    swarm_opti(i, :) = M + rand^2 * sin(2 * pi * rand) * pop(i, :) / 2;
                else
                    swarm_opti(i, :) = M - rand^2 * sin(2 * pi * rand) * pop(i, :) / 2;
                end
            end
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 8
            % 二次反向学习
            M = (lb + ub) / 2;
            op_pop = lb + ub - pop;
            for i = 1:size(pop, 1)
                swarm_opti(i, :) = unifrnd(M, op_pop(i, :));
            end
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 9
            % 准反向学习 (QOL)
            M = (lb + ub) / 2;
            op_pop = lb + ub - pop;
            for i = 1:size(pop, 1)
                swarm_opti(i, :) = rand * (M - op_pop(i, :)) + op_pop(i, :);
            end
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 10
            % 对数螺旋反向学习
            for i = 1:size(pop, 1)
                op_pop(i, :) = rand * ub + rand * lb - bestx;
                b = 1;
                l = 2 * rand - 1;
                swarm_opti(i, :) = abs(bestx - op_pop(i, :)) * exp(b * l) * cos(2 * pi * l) + bestx;
            end
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 11
            % Beta反向学习
            pr = 0.5;
            for i = 1:size(pop, 1)
                if rand <= pr
                    swarm_opti(i, :) = lb + rand(1, size(pop, 2)).*(ub - pop(i, :));
                else
                    spread = 1 + 4 * rand;
                    mode = rand;
                    if mode < 0.5
                        peak = ((spread - 2) * mode + 1) / (spread * (1 - mode));
                        alpha = spread * peak;
                        beta = spread;
                    else
                        peak = (2 - spread) / spread + (spread - 1) / (spread * mode);
                        alpha = spread;
                        beta = spread * peak;
                    end
                    swarm_opti(i, :) = (ub - lb).*betarnd(alpha, beta, 1, size(pop, 2)) + lb;
                end
            end
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        case 12
            % 加权反向学习
            w = rand;
            swarm_opti = w * lb + (1 - w) * ub - w * pop;
            Flag4ub = swarm_opti > ub;
            Flag4lb = swarm_opti < lb;
            swarm_opti = (swarm_opti.*(~(Flag4ub + Flag4lb))) + ub.*Flag4ub + lb.*Flag4lb;

            fitness = zeros(size(pop, 1), 1);
            for i = 1:size(pop, 1)
                fitness(i) = fobj(pop(i, :));
                op_fitness = fobj(swarm_opti(i, :));
                if besty > op_fitness
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
                if op_fitness < fitness(i)
                    pop(i, :) = swarm_opti(i, :);
                    fitness(i) = op_fitness;
                end

                if op_fitness < besty
                    besty = op_fitness;
                    bestx = swarm_opti(i, :);
                end
            end

        otherwise
            error('Invalid opposition-based learning type');
    end
end