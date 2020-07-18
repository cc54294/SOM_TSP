function myPath = RSOMpath( W,Citys )
% ���� TSP ·�����������е�����)
N=size(Citys,1);
myPath=zeros(N,1);
M=size(W,1);
for i=1:N
   [~,index]=min(sum((repmat(Citys(i,:),M,1)-W).^2,2));
   myPath(i)=index;
end
[~,index]=sort(myPath);
myPath=index;
end

