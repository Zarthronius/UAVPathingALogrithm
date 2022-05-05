%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
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
GADATA=[1  10  4; % Coldstream
        2   3 17; % Carlisle
        3  11 18; % Allenheads
        4  18 23; % Darlington
        5   7 12; % Morpeth
        6  18  9; % Amble
        7  29 23; % Whitby
        8  17 25; % Catterick
        9  13 15; % Corbridge
        10 12 15; % Hexham
        11  1 15; % Gretna
        12  9  2; % Duns
        13 20 15; % North Shields
        14  5 26; % Kendal
        15  9 23; % Kirkby Stephen
        16 10 12; % Bellingham
        17  7 11; % Kielder
        18 14  6; % Chillingham
        19 13 19; % Stanhope
        20 24 22; % Guisborough
        21 22 20; % Hartlepool
        22 11 11; % Otterburn
        23 17  5; % Seahouses
        24  1 21]; % Keswick
GAENDNODE = 8; %
GADATAFULL = [GASTART; GADATA]; %
MAXDIST = 300; %
MINDIST = distance(GADATAFULL,1,GAENDNODE);%
GANODEWEIGHT = 0.01;%

    
% remember n! possible answers
GAEPOC=500;
GAEPOCRANGE = 0;                % stops after no. epocs with no improvement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ELITE=[0,1]; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LOGGING=0; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EXECUTIONS = 50;
format compact

for i = 1:length(ELITE)                                               % for each population size
    fprintf("ELITISM: %d\n", ELITE(i));
    result=zeros(EXECUTIONS,2);                                        % initialise matrix
    %k = 1;
    
    for j = 1:EXECUTIONS                                                                     % 50 times
        fprintf("%d\n",j);
        experiment = GA(GAPOPULATIONSIZE,GAMUTATIONRATE,GADATA,GAEPOC,ELITE(i),LOGGING,GASTART,GAENDNODE,MAXDIST,MINDIST,GANODEWEIGHT,GAEPOCRANGE);
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

    line = sprintf("Best Fitness: Elitism %d",ELITE(i));
    plot(x,best,"DisplayName",line);
    hold on        
    %plot(mod(xavg,50),avg,"DisplayName","Average Fitness");
end

legend
%xlim([1 experiment.resultEpoc+1]);
xlim([1 EXECUTIONS]);
xlabel("EPOC");
ylabel("Fitness");
grid
% title('Performance Characteristic of GA', ['STATUS: ' status ' BUILD: ' num2str(build) 's EXECUTION: ' num2str(exprun) 's EPOCS: ' num2str(experiment.bestEpoc)]);
hold off
