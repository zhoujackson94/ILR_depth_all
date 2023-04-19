clear; close all;

rand('seed',85);


T1 = 0; % time domain left-most point
T2 = 5; % time domain right-most point
total = 1000; % sample size
lambda = @(x) ones(size(x)); % intensity function
max_r = 1; % maximum value of the intensity function
r = 1; % hyper-parameter r in ILR depth formula
select = 10; 

lambda_all = {};
for i=1:total
    lambda_all{i} = lambda;
end

% Generate point processes
[S,num] = PP_generating(T1,T2,total,lambda,max_r);

% Compute the ILR depth
[one_dim,dep_value] = ILR_depth(S,r,lambda_all,T1,T2);


% Plot Fig. 3(a) in the paper
figure(3)
plot(1:length(one_dim),one_dim,'b.-','LineWidth',2,'MarkerSize',15)
set(gca,'FontSize',20)
xlabel('cardinality')
ylabel('one dimensional depth')

% Plot Fig. 3(b) in the paper
figure(4)
topDepVisual("top", select, dep_value, S, T1, T2);
set(gca,'xtick',[T1 1 2 3 4 T2])