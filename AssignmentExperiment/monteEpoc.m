%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% EDITED BY: W20016567
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MONTE PLOT PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear

% GAPOPULATIONSIZE=50;
GAPOPULATIONSIZE=100;
GAMUTATIONRATE=0.1;
GASTART = [1 2 3];
GADATA = readmatrix('coords');
GAENDNODE = 18; %
GADATAFULL = [GASTART; GADATA]; %
MAXDIST = 100; %
MINDIST = distance(GADATAFULL,1,GAENDNODE);%
GANODEWEIGHT = 0.01;%
    
% remember n! possible answers
GAEPOC=[2,10,100,200,500]; %1000];
GAEPOCRANGE = 0; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ELITE=1; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LOGGING=0; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EXECUTIONS = 50;
format compact

for i = 1:length(GAEPOC)                                               % for each population size
    fprintf("EPOCS: %d\n", GAEPOC(i));
    result=zeros(EXECUTIONS,2);                                        % initialise matrix
    %k = 1;
    
    for j = 1:EXECUTIONS                                                                     % 50 times
        fprintf("%d\n",j);
        experiment = GA(GAPOPULATIONSIZE,GAMUTATIONRATE,GADATA,GAEPOC(i),ELITE,LOGGING,GASTART,GAENDNODE,MAXDIST,MINDIST,GANODEWEIGHT,GAEPOCRANGE);
        experiment.execute();        
        result(j,:) = [j experiment.bestInd.fitness]; %experiment.stats(50,3)];%stats(50,2) experiment.stats(50,3)];
        %averages = experiment.stats(j,3);

    end
    %averages(i,:) = [i*50-25 mean(bests)];

    x = result(:,1);
    best = result(:,2);
    %xavg = averages(:,1);
    %avg = result(:,3);
    if experiment.success
        status = 'COMPLETE';
    else
        status = sprintf('BEST FIT : [%4d] %s',experiment.bestInd.fitness,evalc('disp(experiment.bestInd.gene)'));
    end

    line = sprintf("Best Fitness: Epocs %d",GAEPOC(i));
    plot(x,best,"DisplayName",line);
    hold on        
    %plot(mod(xavg,50),avg,"DisplayName","Average Fitness");
end

legend
%xlim([1 experiment.resultEpoc+1]);
xlim([1 EXECUTIONS]);
xlabel("Executions");
ylabel("Fitness");
grid
title('Monte Carlo Epoc Comparison');
% title('Performance Characteristic of GA', ['STATUS: ' status ' BUILD: ' num2str(build) 's EXECUTION: ' num2str(exprun) 's EPOCS: ' num2str(experiment.bestEpoc)]);
hold off
