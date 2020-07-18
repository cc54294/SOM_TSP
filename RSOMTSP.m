clear;
clc;

shortestPath=load('./data/att48.tour.txt'); % 最短路径城市序号 idx
Citys=load('./data/att48.tsp.txt'); % 城市坐标 (idx, x, y)

Citys=Citys(:,[2,3]); %城市坐标 (x,y)
CitysNum=size(Citys,1);  % 城市个数

%初始化参数 
alpha=0.1; % 学习率
Tint=1; % 检查间隔
N=3; % 初始神经元个数
C=zeros(3,1); % 每个神经元的计数器
W=rands(3,2); % 每个神经元的参数 (维度和城市坐标维度一样，2）
Tmax=150;  % 最大迭代次数

for t=1:Tmax   %迭代次数
    for i=1:CitysNum  %遍历所有城市
        Dis=sum((repmat(Citys(i,:),N,1)-W).^2,2); %求出城市i与N个输出神经元的距离
        [minDis, index]=min(Dis); %index表示所有神经元与当前城市的距离排序结果
        
        % index1 表示 index 前一个神经元，index2 表示 index 后一个神经元
		index1=index-1;
        if index1<1
            index1=N;
        end
        index2=index+1;
        if index2>N
            index2=1;
        end
        
        % 更新神经元 index、index1、index2 的参数
        W(index,:)=W(index,:)+alpha*(Citys(i,:)-W(index,:));
        W(index1,:)=W(index1,:)+alpha*(Citys(i,:)-W(index1,:));
        W(index2,:)=W(index2,:)+alpha*(Citys(i,:)-W(index2,:));
        
        % index 计数器加 1
        C(index)=C(index)+1;
    end
    
    % 每过 Tint 次就增加神经元
    if mod(t,Tint)==0
        [maxC,index]=max(C); % index表示计数器值最大的那个神经元
        
        % index1 表示 index 前一个神经元，index2 表示 index 后一个神经元
        index1=index-1;
        if index1<1 
            index1=N;
        end
        index2=index+1;
        if index2>N
            index2=1;
        end
        
        dist1=sum((W(index,:)-W(index1,:)).^2);
        dist2=sum((W(index,:)-W(index2,:)).^2);
        
        if dist1>dist2 
            % dist1 > dist2 则在 index1 和 index 之间插入新节点
            if index==1
                W=[W(1:N,:);(W(index,:)+W(index1,:))/2]; %在index1和index中间插入新的神经元
                C(index,:)=C(index,:)/2;
                C=[C(1:N,:);C(index)];
            else
                W=[W(1:index1,:);(W(index,:)+W(index1,:))/2;W(index:N,:)];%在index1和index中间插入新的神经元
                C(index,:)=C(index,:)/2;
                C=[C(1:index1,:);C(index);C(index:N,:)];
            end
        else 
            % dist1 <= dist2 则在 index2 和 index 之间插入新节点
            if index==N 
                W=[W(1:N,:);(W(index,:)+W(index2,:))/2];
                C(index,:)=C(index,:)/2;
                C=[C(1:N,:);C(index)];
            else
                W=[W(1:index,:);(W(index,:)+W(index2,:))/2;W(index2:N,:)];
                C(index,:)=C(index,:)/2;
                C=[C(1:index,:);C(index);C(index2:N,:)];
            end
        end
        N=N+1;
    end 
		
    displayW(Citys,W,t);
    pause(0.001);
end

myPath=RSOMpath(W,Citys);
myDis=Distance(Citys,myPath);
bestDis=Distance(Citys,shortestPath); 
fprintf('RSOM 结果：%f\n',myDis);
fprintf('最短路径：%f\n',bestDis);