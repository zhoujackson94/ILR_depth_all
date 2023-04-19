function [S,num] = PP_generating(T1,T2,total,lambda,max_r)
% Generate a sample of Poisson process (can be either homogeneous or 
% inhomogeneous). 
%      
%     Inputs:
%         T1 - The lower bound of the domain of S. 
%         T2 - The upper bound of the domain of S. 
%      total - sample size needed. 
%     lambda - The intensity function.
%      max_r - The maximum value of lambda. 

%
%     Output:
%          S - A group of temporal point process (cell format). There will
%              be at least one time event in each generated process. 
%        num - A total*1 vector,each value is the cardinality of the
%              generated process. 


num=zeros(total,1);
for i = 1:total  
    while num(i)==0
        % first generate hpp in [T1, T2]
        n(i) = poissrnd(max_r*(T2-T1));
        x = rand(1, n(i))*(T2-T1)+T1;
        hpp{i} = sort(x);

        % generate IPP by thinning
        U = rand(1, length(hpp{i}));
        ind = find(U < lambda(hpp{i})/max_r);
        S{i} = hpp{i}(ind);
        num(i) = length(S{i});
    end
end   

end