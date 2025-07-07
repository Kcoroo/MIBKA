function [lb,ub,dim,fobj] = Get_Functions(F,dim)
% 标准测试函数集合
switch F
    case 1 % Sphere
        lb = -100; ub = 100;
        fobj = @(x) sum(x.^2);
        
    case 2 % Rastrigin
        lb = -5.12; ub = 5.12;
        fobj = @(x) 10*dim + sum(x.^2 - 10*cos(2*pi*x));
        
    case 3 % Ackley
        lb = -32; ub = 32;
        fobj = @(x) -20*exp(-0.2*sqrt(mean(x.^2))) - ...
                   exp(mean(cos(2*pi*x))) + 20 + exp(1);
        
    case 4 % Griewank
        lb = -600; ub = 600;
        fobj = @(x) sum(x.^2)/4000 - prod(cos(x./sqrt(1:dim))) + 1;
        
    case 5 % Rosenbrock
        lb = -30; ub = 30;
        fobj = @(x) sum(100*(x(2:end) - x(1:end-1).^2).^2 + (1 - x(1:end-1)).^2);
        
    otherwise
        error('Invalid function number');
end

% 统一为向量形式
lb = lb * ones(1,dim);
ub = ub * ones(1,dim);
end