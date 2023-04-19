function plotEuclidean(S,lambda,T1,T2)

% Make the conditional depth contour plot in Euclidean space
%      
%     Inputs:
%          S - The original point processes. 
%         T1 - The lower bound of the domain of S. 
%         T2 - The upper bound of the domain of S. 
%     lambda - The intensity function.



% ILR transform, construct Phi for a given dimensionality
d=2;
Phi = zeros(d, d+1);
for i = 1:d
    for j = 1:d+1
        if j <= d+1-i
            Phi(i,j) = 1/sqrt((d+1-i)*(d+2-i));
        elseif j == d+2-i
            Phi(i,j) = -sqrt((d+1-i)/(d+2-i)); 
        end
    end
end

total = length(S);
final = zeros(total,d);
for i=1:total
    final(i,:) = S{i};
end

final_bound=[repmat(T1,total,1),final,repmat(T2,total,1)];
three_cor=diff(final_bound,1,2);
ori_gu=prod(three_cor,2).^(1/(d+1));
ori_ilr_u=log(three_cor./repmat(ori_gu,1,d+1))*Phi';

con_depth=zeros(total,1);
for i=1:total
    reali=S{i};
    dim=length(S{i});
    reali_bound=[T1,reali,T2];
    Lam_reali = arrayfun(@(x) integral(lambda,T1,x),reali_bound);
    c = (dim+1)^(dim+1);
    con_depth(i) = 1/(1-log(c/Lam_reali(end)^(dim+1)*prod(diff(Lam_reali))));
end

x=-5:0.1:5;
y=-5:0.1:5;
[X,Y]=meshgrid(x,y);
Z=zeros(size(X));
for i=1:length(Z(1,:))
    for j=1:length(Z(:,1))
        clr=[X(i,j),Y(i,j)]*Phi;
        origin=exp(clr)/sum(exp(clr))*(T2-T1);
        ss=[T1,origin(1)+T1,origin(1)+origin(2)+T1,T2];
        Lam_ss=arrayfun(@(x) integral(lambda,T1,x),ss);
        c = (d+1)^(d+1);
        Z(i,j) = 1/(1-log(c/Lam_ss(end)^(d+1)*prod(diff(Lam_ss))));
    end
end

hold on
for i=1:total
    if con_depth(i)>0.8
        plot(ori_ilr_u(i,1),ori_ilr_u(i,2),'c.')
    elseif con_depth(i)>0.6
        plot(ori_ilr_u(i,1),ori_ilr_u(i,2),'r.')
    elseif con_depth(i)>0.4
        plot(ori_ilr_u(i,1),ori_ilr_u(i,2),'g.')
    elseif con_depth(i)>0.2
        plot(ori_ilr_u(i,1),ori_ilr_u(i,2),'m.')
    else
        plot(ori_ilr_u(i,1),ori_ilr_u(i,2),'k.')
    end
end
set(gca,'FontSize',20)
[C,h]=contour(X,Y,Z,[0.2,0.4,0.6,0.8],'ShowText','on','LineWidth',2);
clabel(C,h,'FontSize',15)
hold off
xlim([-8 8])
ylim([-6 6])
axis equal
set(gca,'xtick',[-6,-4,-2,0,2,4,6])
set(gca,'ytick',[-6,-4,-2,0,2,4,6])


xlabel('u_1^{*}','FontSize',20)
h1=ylabel('u_2^{*}','FontSize',20);
set(h1,'Rotation',0)

end