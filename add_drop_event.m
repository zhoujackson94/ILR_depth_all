function S_final = add_drop_event(S,ob)
% Make each point process have a fixed cardinality.
% Only applicable for Poisson process.
%      
%     Inputs:
%          S - The original point process sample. 
%         ob - The target cardinality. 

%
%     Output:
%    S_final - The final process sample with fixed cardinality. 


S_final = {};
total = length(S);

for i=1:total
    a=S{i};
    l=length(a);
    if l>ob
        S_final{i} = a(sort(randperm(l,ob)));

    elseif l<ob
        diff1=ob-l;
        for j=1:diff1
            U=randperm(total,1);
            aa=S{U};
            ll=length(aa);
            while U==i || ll<1
                U=randperm(total,1);
                aa=S{U};
                ll=length(aa);
            end
            U1=randperm(ll,1);
            a(l+j)=aa(U1);
            while length(unique(a))<l+j
                U1=randperm(ll,1);
                a(l+j)=aa(U1);
            end
        end
        S_final{i}=sort(a);
    else
        S_final{i}=a;
    end
end

end