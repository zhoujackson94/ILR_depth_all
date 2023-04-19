function topDepVisual(option, select, dep, S, T1, T2)

% Plot the realizations with top/bottom depth.
%      
%     Inputs:
%     option - string input: 'top' or 'bottom'. 
%        top - The number of top depth realizations. 
%        dep - The depth valueof all realizations. 
%          S - The original point processes. 
%         T1 - The lower bound of the domain of S. 
%         T2 - The upper bound of the domain of S. 

if option == "top"
    [~,ind] = maxk(dep,select);
elseif option == "bottom"
    [~,ind] = mink(dep,select);
else
    error('The input should be either top or bottom.');
end

hold on
for i=1:select
    plot(S{ind(i)},select+1-i,'b.','MarkerSize',15)   
end
hold off
ylim([0 select+1])
xlim([T1 T2])
set(gca,'FontSize',20)
set(gca,'ytick',[0 1 2 3 4 5 6 7 8 9 10 11])
set(gca,'yticklabel',{' ','10th','9th','8th','7th','6th','5th','4th','3rd','2nd','1st',' '})
end