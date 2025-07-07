%% 21 Chaotic maps for meta-heuristics
% 21 ����ӳ��
%% ��ע΢�Ź��ںţ��Ż��㷨��   Swarm-Opti
% https://mbd.pub/o/author-a2mVmGpsYw==
clc;clear;close all
%% ��������
N=500; % ���ɵ����ݵ���
Initial_point=0.65; % ��ʼֵ
% ��ʼֵ Initial_Value ����ѡ��0��1֮����������� (��-1��1 , ȡ���ڻ���ӳ��ķ�Χ)
% ���ǣ���Ҫע����ǣ���ʼֵ���ĳЩ����ͼ�Ĳ���ģʽ�����ش�Ӱ��
figure
for map_index=1:21 % 21��
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
    
    x=chaos(map_index,Initial_point,N); % ����ֵ
    
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
%% �����
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
    
    x=chaos(map_index,Initial_point,N); % ����ֵ
    
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

%% ֱ��ͼ
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
    
    x=chaos(map_index,Initial_point,N); % ����ֵ
    
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

