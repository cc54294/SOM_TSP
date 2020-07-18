function myPath = RSOMpath( W,Citys )
% 返回 TSP 路径（包含城市的索引)
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

