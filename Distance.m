function dis = Distance(Citys,myPath)
% ���ܣ�����·�����������Ÿ�·�����ߵľ���
% Citys [���и�����2]
% myPath ����·����Ϊ���� idx ������

N=size(Citys,1);
dis=0;

for i=1:N-1
    dis=dis+sqrt(sum((Citys(myPath(i),:)-Citys(myPath(i+1),:)).^2));
end
dis=dis+sqrt(sum((Citys(myPath(N),:)-Citys(myPath(1),:)).^2));
end

