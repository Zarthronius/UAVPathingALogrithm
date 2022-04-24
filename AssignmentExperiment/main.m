clc;
clear;
format compact
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AUTHOR = "AUTHOR: DR N ELIOT";
DATE = "DATE: 13/11/2021";
VERSION="TSP2 0.02";
% AUTHOR: DR N ELIOT";
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GA TSP PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATES A GA OBJECT AND TIMES THE OPERATION
% POPULATION MUST BE > 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATE: 25/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADDED ELITE SELECTION IN GA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATE: 01/11/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADDED POPULATION LOGGING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GAPOPULATIONSIZE=100;
GAMUTATIONRATE=1.0;
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
% remember n! possible answers
GAEPOC=500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ELITE=1; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LOGGING=0; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf("+------------------------------------------------------+\n");
fprintf("| %s\n",AUTHOR);
fprintf("| %s\n",DATE);
fprintf("+------------------------------------------------------+\n");
if ELITE == 1
  fprintf("| GENETIC ALGORITHM WITH ELITISM    (VERSION:%s)|\n",VERSION);
else
  fprintf("| GENETIC ALGORITHM WITHOUT ELITISM (VERSION:%s) |\n",VERSION);
end
fprintf("+------------------------------------------------------+\n");
fprintf("POPULATION = %d\n",GAPOPULATIONSIZE);
fprintf("MUTATION RATE = %f\n",GAMUTATIONRATE);
fprintf("EPOC = %d\n",GAEPOC);
fprintf("--------------------------------------------------------\n");
tic
experiment = GA(GAPOPULATIONSIZE,GAMUTATIONRATE,GADATA,GAEPOC,ELITE,LOGGING);
build = toc;
fprintf("BUILD TIME: %fs\n", build);
tic
experiment.execute();
exprun = toc;
fprintf("EXCUSION TIME: %fs\n", exprun);
fprintf("TOTAL TIME: %fs\n", build+exprun);
fprintf("====================================================\n");
if experiment.success
    fprintf("SUCCESSFUL RUN!\n");
    fprintf("TARGET FOUND IN EPOC:%d\n",experiment.resultEpoc);
else
    fprintf("BEST ANSWER ONLY! (EPOC:%d)\n",experiment.bestEpoc);    
    fprintf("[%s]%s",num2str(experiment.bestInd.fitness),evalc('disp(experiment.bestInd.gene)'));
end
fprintf("====================================================\n");




