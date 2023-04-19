clear; 

rand('seed',74);


T1 = 0; % time domain left-most point
T2 = 2*pi; % time domain right-most point
total = 1000; % sample size
lambda = @(x) cos(x)+1; % intensity function
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


% Plot Fig. K.10(a) in the paper
figure(3)
plot(1:length(one_dim),one_dim,'b.-','LineWidth',2,'MarkerSize',15)
set(gca,'FontSize',20)
xlabel('cardinality')
ylabel('one dimensional depth')
set(gca,'xtick',[0 3 6 9 12 15])


% Plot Fig. K.10(b) in the paper
figure(4)
subplot(2,1,1)
plot(0:0.01:2*pi,cos(0:0.01:2*pi)+1,'b-','LineWidth',2)
set(gca,'box','off')
set(gca,'FontSize',20)
set(gca,'xlim',[0 2*pi])
set(gca,'xticklabel',[])
set(gca,'position',[0.15 0.77 0.75 0.12])
subplot(2,1,2)
topDepVisual("top", select, dep_value, S, T1, T2);
set(gca,'xtick',[T1 pi/2 pi 3*pi/2 T2])
set(gca,'xticklabel',{'0','\pi/2','\pi','3\pi/2','2\pi'})
set(gca,'position',[0.15 0.199 0.75 0.57])