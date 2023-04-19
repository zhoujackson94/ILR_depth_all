clear; close all;

rand('seed',85);


T1 = 0; % time domain left-most point
T2 = 2; % time domain right-most point
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

% Make all realizations with the cardinality 2
S_final = add_drop_event(S,2);

% Plot Fig. 2(a) in the paper
figure(1)
ternaryPlotSimplex(S_final,T1,T2,lambda)
set(gca,'xtick',[0 0.5 1 1.5 2])
set(gca,'ytick',[0 0.5 1 1.5 2])

% Plot Fig. 2(b) in the paper
figure(2)
plotEuclidean(S_final,lambda,T1,T2)

