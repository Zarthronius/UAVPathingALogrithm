%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% EDITED BY: W20016567
% DATE: 21/04/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SAMPLE PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
main
format compact
x = experiment.stats(:,1);
best = experiment.stats(:,2);
avg = experiment.stats(:,3);
if experiment.success
    status = 'COMPLETE';
else
    status = sprintf('BEST FIT : [%4d] %s',experiment.bestInd.fitness,evalc('disp(experiment.bestInd.gene)'));
end

figure("Name","Fitness Graph");
plot(x,best,"DisplayName","Best Fitness");
hold on
plot(x,avg,"DisplayName","Average Fitness");
legend
%xlim([1 experiment.resultEpoc+1]);
xlabel("EPOC");
ylabel("Fitness");
grid
title('Performance Characteristic of GA', ['MINPATH' num2str(MINDIST)  ' MAX PATH' num2str(MAXDIST) ' NODE WEIGHT: ' num2str(GANODEWEIGHT) '\n STATUS: ' status ' BUILD: ' num2str(build) 's EXECUTION: ' num2str(exprun) 's EPOCS: ' num2str(experiment.bestEpoc)]);
hold off