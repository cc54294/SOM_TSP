function [ ] = displayW( Citys,W,t )
% 功能：画出城市节点和神经元路径
% Citys [城市个数，2] 
% W [神经元个数，2]
% t 迭代次数

N=size(W,1);
figure(1);

scatter(Citys(:,1),Citys(:,2),30,'filled','r');
hold on;

plot(W(:,1),W(:,2),'b- .');
plot(W([1,N],1),W([1,N],2),'b- .');
hold off;

axis off;

F=getframe(gcf);
I=frame2im(F);
[I,map]=rgb2ind(I,256);

% 生成 gif
if t == 1
    imwrite(I,map,'test.gif','gif', 'Loopcount',inf,'DelayTime',0.2);
else
    imwrite(I,map,'test.gif','gif','WriteMode','append','DelayTime',0.2);
end

end

