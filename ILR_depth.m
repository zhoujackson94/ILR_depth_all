function [one_dim,dep] = ILR_depth(S,r,lambda,T1,T2)
% ILR depth computation for a sample of temporal point process.
%      
%     Inputs:
%          S - A group of temporal point process (cell format). 
%          r - The hyper-parameter to control weight of cardinality.
%     lambda - The intensity function of S (cell format). If lambda is a 
%              constant c, input it as lambda = @(x) c*ones(size(x)). Each
%              cell corresponds to the intensity function of a process. If
%              it is a Poisson process group, then all cells are the same. 
%         T1 - The lower bound of the domain of S. 
%         T2 - The upper bound of the domain of S. 
%
%     Output:
%      one_dim - one dimensional depth for different cardinalities
%          dep - The ILR depth for each realization in S.


total = length(S);
num = zeros(total,1);
for i=1:total
    num(i) = length(S{i});
end

w=zeros(total,1);
D1=zeros(max(num),1);
for i=1:max(num)
    D1(i)=min(length(num(num<=i))/total,length(num(num>=i))/total);
end
one_dim = D1/max(D1);
for i=1:total
    w(i)=D1(num(i))/max(D1);
end

% Calculate ILR depth
dep=zeros(total,1);
for i=1:total
    reali=S{i};
    dim=num(i);
    reali_bound=[T1,reali,T2];
    Lam_reali = arrayfun(@(x) integral(lambda{i},T1,x),reali_bound);
    c = (dim+1)^(dim+1);
    con_dep = 1/(1-log(c/Lam_reali(end)^(dim+1)*prod(diff(Lam_reali))));
    dep(i)=w(i)^r*con_dep;
end

end