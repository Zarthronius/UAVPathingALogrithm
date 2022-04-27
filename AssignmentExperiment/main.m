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
GAPOPULATIONSIZE=5;
GAMUTATIONRATE=1.0;
GASTART = [1 2 3];
GADATA=[2  10  4; % Coldstream
        3   3 17; % Carlisle
        4  11 18; % Allenheads
        5  18 23; % Darlington
        6   7 12; % Morpeth
        7  18  9; % Amble
        8  29 23; % Whitby
        9  17 25; % Catterick
        10 13 15; % Corbridge
        11 12 15; % Hexham
        12 1 15; % Gretna
        13 9  2; % Duns
        14 20 15; % North Shields
        15 5 26; % Kendal
        16 9 23; % Kirkby Stephen
        17 10 12; % Bellingham
        18 7 11; % Kielder
        19 14  6; % Chillingham
        20 13 19; % Stanhope
        21 24 22; % Guisborough
        22 22 20; % Hartlepool
        23 11 11; % Otterburn
        24 17  5; % Seahouses
        25  1 21]; % Keswick
GAENDNODE = 8;
GADATAFULL = [GASTART; GADATA]; %
MAXDIST = 200; %
MINDIST = distance(GADATAFULL,1,GAENDNODE);%
% remember n! possible answers
GAEPOC=5000;

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
experiment = GA(GAPOPULATIONSIZE,GAMUTATIONRATE,GADATA,GAEPOC,ELITE,LOGGING,GASTART,GAENDNODE,MAXDIST,MINDIST);
build = toc;
fprintf("BUILD TIME: %fs\n", build);
tic
experiment.execute();
exprun = toc;
fprintf("EXCUSION TIME: %fs\n", exprun);
fprintf("TOTAL TIME: %fs\n", build+exprun);
fprintf("====================================================\n");

    %% removes excess nodes after path and gets coordinates for mapping
    genelength = length(experiment.bestInd.gene);
    result = zeros(genelength,3);
    for i = 1:genelength
        row = experiment.bestInd.gene(1,i); %value of 1st col in GADATA
        result(i,:) = GADATAFULL(row,:);
    end    
    xall = GADATAFULL(:,2);  %x coords
    yall = GADATAFULL(:,3);  %y coords
    
    for i = 1:size(result,1)
        if result(i,1) == GAENDNODE
            row = i;
        end
    end

    result(row+1:end, :) = [ ]; %
    resultgene(1,:) = result(:,1); %

if experiment.success
    fprintf("SUCCESSFUL RUN!\n");
    fprintf("TARGET FOUND IN EPOC: %d\n",experiment.resultEpoc);
else
    fprintf("BEST ANSWER ONLY! (EPOC: %d)\n",experiment.bestEpoc);
end
fprintf("[%s]%s",num2str(experiment.bestInd.fitness),evalc('disp(resultgene)'));
fprintf("====================================================\n");




