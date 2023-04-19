clear; 

rand('seed',74);


T1 = 0; % time domain left-most point
T2 = pi/2; % time domain right-most point
total = 1000; % sample size
lambda = @(x) cos(4*x)+1; % intensity function
max_r = 2; % maximum value of the intensity function
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

% Plot Fig. K.9(a) in the paper
figure(1)
ternaryPlotSimplex(S_final,T1,T2,lambda)
set(gca,'xtick',[0 pi/6 pi/3 pi/2])
set(gca,'xticklabel',{'0','\pi/6','\pi/3','\pi/2'})
set(gca,'ytick',[0 pi/6 pi/3 pi/2])
set(gca,'yticklabel',{'0','\pi/6','\pi/3','\pi/2'})

% Plot Fig. K.9(b) in the paper
figure(2)
plotEuclidean(S_final,lambda,T1,T2)


