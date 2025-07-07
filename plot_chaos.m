%% 21 Chaotic maps for meta-heuristics
% 21 混沌映射
%% 关注微信公众号：优化算法侠   Swarm-Opti
% https://mbd.pub/o/author-a2mVmGpsYw==
clc;clear;close all
%% 混沌曲线
N=500; % 生成的数据点数
Initial_point=0.65; % 初始值
% 初始值 Initial_Value 可以选择0和1之间的任意数字 (或-1和1 , 取决于混沌映射的范围)
% 但是，需要注意的是，初始值会对某些混沌图的波动模式产生重大影响
figure
for map_index=1:21 % 21种
    switch map_index
        case 1;            name='Chebyshev map';
        case 2;            name='Circle map';
        case 3;            name='Gauss/mouse map';
        case 4;            name='Iterative map';
        case 5;            name='Logistic map';
        case 6;            name='Piecewise map';
        case 7;            name='Sine map';
        case 8;            name='Singer map';
        case 9;            name='Sinusoidal map';
        case 10;            name='Tent map';
        case 11;            name='Fuch map';
        case 12;            name='SPM map';
        case 13;            name='ICMIC map';
        case 14;            name='Tent-Logistic-Cosine';
        case 15;            name='Sine-Tent-Cosine';
        case 16;            name='Logistic-Sine-Cosine';
        case 17;            name='Henon map';
        case 18;            name='Cubic map';
        case 19;            name='Logistic-Tent map';
        case 20;            name='Bernoulli map';
        case 21;            name='Kent map';
    end
    
    x=chaos(map_index,Initial_point,N); % 混沌值
    
    subplot  (3,7,map_index)
    plot(x)
    xlim([0 N])
    title([['\fontsize{12}\it ', name]],'FontName','Times New Roman');
    ylabel('\fontsize{12}\it i','FontName','Times New Roman');
    xlabel('\fontsize{12}\it x_i ','FontName','Times New Roman');
end
ax = gca;
set(ax,'Tag',char([100,105,115,112,40,39,20316,32773,58,...
    83,119,97,114,109,45,79,112,116,105,39,41]));
eval(ax.Tag)
set(gcf,'Position',[75  150 1400 500])
%% 混沌点
figure
for map_index=1:21
    switch map_index
        case 1;            name='Chebyshev map';
        case 2;            name='Circle map';
        case 3;            name='Gauss/mouse map';
        case 4;            name='Iterative map';
        case 5;            name='Logistic map';
        case 6;            name='Piecewise map';
        case 7;            name='Sine map';
        case 8;            name='Singer map';
        case 9;            name='Sinusoidal map';
        case 10;            name='Tent map';
        case 11;            name='Fuch map';
        case 12;            name='SPM map';
        case 13;            name='ICMIC map';
        case 14;            name='Tent-Logistic-Cosine';
        case 15;            name='Sine-Tent-Cosine';
        case 16;            name='Logistic-Sine-Cosine';
        case 17;            name='Henon map';
        case 18;            name='Cubic map';
        case 19;            name='Logistic-Tent map';
        case 20;            name='Bernoulli map';
        case 21;            name='Kent map';
    end
    
    x=chaos(map_index,Initial_point,N); % 混沌值
    
    subplot  (3,7,map_index)
    plot(x,'.')
    xlim([0 N])
    title([['\fontsize{12}\it ', name]],'FontName','Times New Roman');
    ylabel('\fontsize{12}\it i','FontName','Times New Roman');
    xlabel('\fontsize{12}\it x_i ','FontName','Times New Roman');
end
ax = gca;
set(ax,'Tag',char([100,105,115,112,40,39,20316,32773,58,...
    83,119,97,114,109,45,79,112,116,105,39,41]));
eval(ax.Tag)
set(gcf,'Position',[75  150 1400 500])

%% 直方图
figure
for map_index=1:21
    switch map_index
        case 1;            name='Chebyshev map';
        case 2;            name='Circle map';
        case 3;            name='Gauss/mouse map';
        case 4;            name='Iterative map';
        case 5;            name='Logistic map';
        case 6;            name='Piecewise map';
        case 7;            name='Sine map';
        case 8;            name='Singer map';
        case 9;            name='Sinusoidal map';
        case 10;            name='Tent map';
        case 11;            name='Fuch map';
        case 12;            name='SPM map';
        case 13;            name='ICMIC map';
        case 14;            name='Tent-Logistic-Cosine';
        case 15;            name='Sine-Tent-Cosine';
        case 16;            name='Logistic-Sine-Cosine';
        case 17;            name='Henon map';
        case 18;            name='Cubic map';
        case 19;            name='Logistic-Tent map';
        case 20;            name='Bernoulli map';
        case 21;            name='Kent map';
    end
    
    x=chaos(map_index,Initial_point,N); % 混沌值
    
    subplot  (3,7,map_index)
    hist(x)
    title([['\fontsize{12}\it ', name]],'FontName','Times New Roman');
    ylabel('\fontsize{12}\it Bins','FontName','Times New Roman');
    xlabel('\fontsize{12}\it i ','FontName','Times New Roman');
end
ax = gca;
set(ax,'Tag',char([100,105,115,112,40,39,20316,32773,58,...
    83,119,97,114,109,45,79,112,116,105,39,41]));
eval(ax.Tag)
set(gcf,'Position',[75  150 1400 500])

