clear;
clc;

shortestPath=load('./data/att48.tour.txt'); % ���·��������� idx
Citys=load('./data/att48.tsp.txt'); % �������� (idx, x, y)

Citys=Citys(:,[2,3]); %�������� (x,y)
CitysNum=size(Citys,1);  % ���и���

%��ʼ������ 
alpha=0.1; % ѧϰ��
Tint=1; % �����
N=3; % ��ʼ��Ԫ����
C=zeros(3,1); % ÿ����Ԫ�ļ�����
W=rands(3,2); % ÿ����Ԫ�Ĳ��� (ά�Ⱥͳ�������ά��һ����2��
Tmax=150;  % ����������

for t=1:Tmax   %��������
    for i=1:CitysNum  %�������г���
        Dis=sum((repmat(Citys(i,:),N,1)-W).^2,2); %�������i��N�������Ԫ�ľ���
        [minDis, index]=min(Dis); %index��ʾ������Ԫ�뵱ǰ���еľ���������
        
        % index1 ��ʾ index ǰһ����Ԫ��index2 ��ʾ index ��һ����Ԫ
		index1=index-1;
        if index1<1
            index1=N;
        end
        index2=index+1;
        if index2>N
            index2=1;
        end
        
        % ������Ԫ index��index1��index2 �Ĳ���
        W(index,:)=W(index,:)+alpha*(Citys(i,:)-W(index,:));
        W(index1,:)=W(index1,:)+alpha*(Citys(i,:)-W(index1,:));
        W(index2,:)=W(index2,:)+alpha*(Citys(i,:)-W(index2,:));
        
        % index �������� 1
        C(index)=C(index)+1;
    end
    
    % ÿ�� Tint �ξ�������Ԫ
    if mod(t,Tint)==0
        [maxC,index]=max(C); % index��ʾ������ֵ�����Ǹ���Ԫ
        
        % index1 ��ʾ index ǰһ����Ԫ��index2 ��ʾ index ��һ����Ԫ
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
            % dist1 > dist2 ���� index1 �� index ֮������½ڵ�
            if index==1
                W=[W(1:N,:);(W(index,:)+W(index1,:))/2]; %��index1��index�м�����µ���Ԫ
                C(index,:)=C(index,:)/2;
                C=[C(1:N,:);C(index)];
            else
                W=[W(1:index1,:);(W(index,:)+W(index1,:))/2;W(index:N,:)];%��index1��index�м�����µ���Ԫ
                C(index,:)=C(index,:)/2;
                C=[C(1:index1,:);C(index);C(index:N,:)];
            end
        else 
            % dist1 <= dist2 ���� index2 �� index ֮������½ڵ�
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
fprintf('RSOM �����%f\n',myDis);
fprintf('���·����%f\n',bestDis);