function dis = Distance(Citys,myPath)
% 功能：给定路径，返回沿着该路径行走的距离
% Citys [城市个数，2]
% myPath 城市路径，为城市 idx 的序列

N=size(Citys,1);
dis=0;

for i=1:N-1
    dis=dis+sqrt(sum((Citys(myPath(i),:)-Citys(myPath(i+1),:)).^2));
end
dis=dis+sqrt(sum((Citys(myPath(N),:)-Citys(myPath(1),:)).^2));
end

