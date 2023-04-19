function ternaryPlotSimplex(S,T1,T2,lambda)

% Make the ternary plot in simplex space with depth contour
%      
%     Inputs:
%          S - The original point processes. 
%         T1 - The lower bound of the domain of S. 
%         T2 - The upper bound of the domain of S. 
%     lambda - The intensity function.


total = length(S);
final = zeros(total,2);
for i=1:total
    final(i,:) = S{i};
end

final_bound=[repmat(T1,total,1),final,repmat(T2,total,1)];
three_cor=diff(final_bound,1,2);
visual=zeros(total,2);


U0 = 0;
V0 = 0;
B = [U0, V0];
A = [U0+(T2-T1)/sqrt(3), V0+T2-T1];
C = [U0+2*(T2-T1)/sqrt(3), V0];


con_depth=zeros(total,1);
for i=1:total
    reali=S{i};
    dim=length(S{i});
    reali_bound=[T1,reali,T2];
    Lam_reali = arrayfun(@(x) integral(lambda,T1,x),reali_bound);
    c = (dim+1)^(dim+1);
    con_depth(i) = 1/(1-log(c/Lam_reali(end)^(dim+1)*prod(diff(Lam_reali))));
end


% Make the plot
hold on;
plot([A(1),B(1)],[A(2),B(2)],'k','LineWidth',2);
plot([C(1),B(1)],[C(2),B(2)],'k','LineWidth',2);
plot([A(1),C(1)],[A(2),C(2)],'k','LineWidth',2);
for i=1:total
    visual(i,:)=1/(T2-T1)*(three_cor(i,1)*A+three_cor(i,2)*B+three_cor(i,3)*C);
    % plot(visual(i,1),visual(i,2),'b.','MarkerSize',10)
    if con_depth(i)>0.8
        plot(visual(i,1),visual(i,2),'c.')
    elseif con_depth(i)>0.6
        plot(visual(i,1),visual(i,2),'r.')
    elseif con_depth(i)>0.4
        plot(visual(i,1),visual(i,2),'g.')
    elseif con_depth(i)>0.2
        plot(visual(i,1),visual(i,2),'m.')
    else
        plot(visual(i,1),visual(i,2),'k.')
    end
end

% Draw contour line in ternary plot, in which we find many points in
% simplex space, then calculate the conditional depth of those points, use
% the depth to draw contour line
d=2;
x=0:0.01:2*(T2-T1)/sqrt(3);
y=0:0.01:T2;
[X,Y]=meshgrid(x,y);
z=zeros(d,1);
[m,n]=size(X);
k=0;
for i=1:m
    for j=1:n
        if Y(i,j)>0 && Y(i,j)<sqrt(3)*X(i,j) && sqrt(3)*X(i,j)+Y(i,j)<2*T2
            k=k+1;
            z(1,k)=X(i,j);
            z(2,k)=Y(i,j);
        end
    end
end
u=zeros(d+1,k);
u(1,:)=z(2,:);
u(3,:)=sqrt(3)/2*z(1,:)-z(2,:)/2;
u(2,:)=T2-T1-u(1,:)-u(3,:);
s=zeros(d+2,k);
s(1,:)=repmat(T1,1,k);
s(2,:)=u(1,:);
s(3,:)=u(1,:)+u(2,:);
s(4,:)=u(1,:)+u(2,:)+u(3,:);
Lam_s=arrayfun(@(x) integral(lambda,T1,x),s);
u(1,:)=Lam_s(2,:)-Lam_s(1,:);
u(2,:)=Lam_s(3,:)-Lam_s(2,:);
u(3,:)=Lam_s(4,:)-Lam_s(3,:);

ff=zeros(1,length(u(1,:)));
for i=1:length(u(1,:))
    reali=[Lam_s(2,i),Lam_s(3,i)];
    dim=2;
    reali_bound=[Lam_s(1,i),reali,Lam_s(4,i)];
    c = (dim+1)^(dim+1);
    ff(i) = 1/(1-log(c/reali_bound(end)^(dim+1)*prod(diff(reali_bound))));
end

nx = 50; ny = 50;
[XX,YY] = meshgrid(linspace(min(z(1,:)),max(z(1,:)),nx),linspace(min(z(2,:)),max(z(2,:)),ny)) ;
ZZ=griddata(z(1,:),z(2,:),ff,XX,YY);
set(gca,'FontSize',20)
[C,h]=contour(XX,YY,real(ZZ),[0.2,0.4,0.6,0.8],'ShowText','on','LineWidth',2); 
clabel(C,h,'FontSize',15)
hold off
axis equal


end