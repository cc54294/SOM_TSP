function [ ] = displayW( Citys,W,t )
% ���ܣ��������нڵ����Ԫ·��
% Citys [���и�����2] 
% W [��Ԫ������2]
% t ��������

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

% ���� gif
if t == 1
    imwrite(I,map,'test.gif','gif', 'Loopcount',inf,'DelayTime',0.2);
else
    imwrite(I,map,'test.gif','gif','WriteMode','append','DelayTime',0.2);
end

end

