function [Bestscore,Best_pos,Convergence_curve]=BKA(N,Maxits,lb,ub,dim,fobj)
    p=0.9;
    XPos=initialization(N,dim,ub,lb);
    for i =1:N
        XFit(i)=fobj(XPos(i,:));
    end
    Convergence_curve=zeros(1,Maxits);

    for t=1:Maxits
        r=rand;
        [~,sorted_indexes]=sort(XFit);
        XLeader_Pos=XPos(sorted_indexes(1),:);
        XLeader_Fit = XFit(sorted_indexes(1));

        %% 探索行为
        for i=1:N
            n=0.05*exp(-2*(t/Maxits)^2);
            if p<r
                XPosNew(i,:)=XPos(i,:)+n.*(1+sin(r))*XPos(i,:);
            else
                XPosNew(i,:)= XPos(i,:).*(n*(2*rand(1,dim)-1)+1);
            end
            XPosNew(i,:) = max(XPosNew(i,:),lb);
            XPosNew(i,:) = min(XPosNew(i,:),ub);
            XFit_New(i)=fobj(XPosNew(i,:));
            if(XFit_New(i)<XFit(i))
                XPos(i,:) = XPosNew(i,:);
                XFit(i) = XFit_New(i);
            end

            %% 开发行为
            m=2*sin(r+pi/2);
            s = randi([1,N],1); % 修正为从 1 到 N 随机选择
            r_XFitness=XFit(s);
            ori_value = rand(1,dim);
            cauchy_value = tan((ori_value-0.5)*pi);
            if XFit(i)< r_XFitness
                XPosNew(i,:)=XPos(i,:)+cauchy_value .* (XPos(i,:)-XLeader_Pos);
            else
                XPosNew(i,:)=XPos(i,:)+cauchy_value .* (XLeader_Pos-m.*XPos(i,:));
            end
            XPosNew(i,:) = max(XPosNew(i,:),lb);
            XPosNew(i,:) = min(XPosNew(i,:),ub);
            XFit_New(i)=fobj(XPosNew(i,:));
            if(XFit_New(i)<XFit(i))
                XPos(i,:) = XPosNew(i,:);
                XFit(i) = XFit_New(i);
            end
        end

        %% 更新最优解
        [Best_Fitness,idx]=min(XFit);
        Best_Pos=XPos(idx,:);
        if Best_Fitness < Convergence_curve(max(1,t-1))
            Bestscore=Best_Fitness;
            Best_pos=Best_Pos;
        else
            Bestscore=Convergence_curve(max(1,t-1));
            Best_pos=XLeader_Pos;
        end
        Convergence_curve(t)=Bestscore;
    end
end